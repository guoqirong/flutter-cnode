import 'package:flutter_cnode/resp/api.dart';
import 'package:flutter_cnode/utils/dio_resp.dart';

class IndexResp {
  static Future<Map<String, dynamic>> findList() async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        Api.apiTopics,
        params: {
          'page': 1,
          'tab': 'all',
          'limit': 20,
          'mdrender': true
        },
        isList: true
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}