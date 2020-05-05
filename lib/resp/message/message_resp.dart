import 'package:flutter_cnode/resp/api.dart';
import 'package:flutter_cnode/utils/dio_resp.dart';

class MessageResp {
  static Future<Map<String, dynamic>> findMeaaageCount(token) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        Api.apiMessageCount,
        queryParameters: {
          'accesstoken': token,
        },
        isList: false,
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> findMyMessages(params) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        Api.apiMessage,
        queryParameters: {
          'accesstoken': params['token'],
          'mdrender': params['mdrender']??true
        },
        isList: false,
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> markAllMessages(params) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.post,
        Api.apiMessageCountMarkall,
        params: {
          'accesstoken': params['token']
        },
        isList: false,
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> markOneMessages(params) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.post,
        '${Api.apiMessageCountMmarkone}${params["id"]}',
        params: {
          'accesstoken': params['token']
        },
        isList: false,
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}