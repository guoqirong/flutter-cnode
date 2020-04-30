import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/config/dio_error_code.dart';

class DioUtils {

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  static Dio _dio;

  Dio getDio(){
    return _dio;
  }

  DioUtils._internal(){
    var options = BaseOptions(
      connectTimeout: 60000,
      receiveTimeout: 60000,
      responseType: ResponseType.plain,
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
    );
    _dio = Dio(options);
    /// 适配数据(根据自己的数据结构，可自行选择添加)
    // _dio.interceptors.add(AdapterInterceptor());
  }

  // 数据返回格式统一，统一处理异常
  Future<Map<String, dynamic>> _request(String method, String url, {
    dynamic data, Map<String, dynamic> queryParameters,
    CancelToken cancelToken, Options options
  }) async {
    var response = await _dio.request(url, data: data, queryParameters: queryParameters, options: _checkOptions(method, options), cancelToken: cancelToken);
    try {
      /// 集成测试无法使用 isolate
      Map<String, dynamic> _map = Config.isTest ? parseData(response.data.toString()) : await compute(parseData, response.data.toString());
      return _map;
    }catch(e){
      print(e);
      return {"code": DioErrorCode.parse_error, "msg": "数据解析错误"};
    }
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future<Map<String, dynamic>> requestNetwork(Method method, String url, {
    Function onSuccess, 
    Function(List list) onSuccessList, 
    Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters, 
    CancelToken cancelToken, Options options, bool isList: false
  }) async {
    // 接口访问
    String m = _getRequestMethod(method);
    debugPrint(url);
    debugPrint(m);
    debugPrint(params.toString());
    debugPrint(queryParameters.toString());
    return await _request(m, url,
      data: params,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken).then((Map<String, dynamic> result) {
      // 返回数据处理
      print(result.toString());
      if (result['success']){
        if (isList){
          if (onSuccessList != null){
            onSuccessList(result['data']);
          }
        }else{
          if (onSuccess != null){
            onSuccess(result['data']);
          }
        }
        return result;
      }else{
        _onError(result['code'], result['msg'], onError);
        return result;
      }
    }, onError: (e, _){
      // 错误处理
      _cancelLogPrint(e, url);
      NetError error = DioErrorCode.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url){
    if (e is DioError && CancelToken.isCancel(e)){
      debugPrint("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError){
    debugPrint("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method){
    String m;
    switch(method){
      case Method.get:
        m = "GET";
        break;
      case Method.post:
        m = "POST";
        break;
      case Method.put:
        m = "PUT";
        break;
      case Method.patch:
        m = "PATCH";
        break;
      case Method.delete:
        m = "DELETE";
        break;
      case Method.head:
        m = "HEAD";
        break;
    }
    return m;
  }
}

Map<String, dynamic> parseData(String data){
  return json.decode(data);
}

enum Method {
  get,
  post,
  put,
  patch,
  delete,
  head
}