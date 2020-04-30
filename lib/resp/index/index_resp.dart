import 'package:flutter_cnode/resp/api.dart';
import 'package:flutter_cnode/utils/dio_resp.dart';

class IndexResp {
  static Future<Map<String, dynamic>> findList(page) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        Api.apiTopics,
        queryParameters: {
          'page': page['page'],
          'tab': page['filterMap']['tab'],
          'limit': page['limit'],
          'mdrender': page['filterMap']['mdrender']??true
        },
        isList: true
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> findDetail(pragma) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        '${Api.apiTopic}${pragma["id"]}',
        queryParameters: {
          'accesstoken': pragma['accesstoken'],
          'mdrender': pragma['mdrender']??true
        },
        isList: false
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}