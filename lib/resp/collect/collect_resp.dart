import 'package:flutter_cnode/resp/api.dart';
import 'package:flutter_cnode/utils/dio_resp.dart';

class CollectResp {
  static Future<Map<String, dynamic>> findList(userName) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        '${Api.apiTopicCollectList}$userName',
        isList: true
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> collectTopic(params) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.post,
        Api.apiTopicCollect,
        params: {
          'accesstoken': params['token'],
          'topic_id': params['id'],
        },
        isList: false,
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> deCollectTopic(params) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.post,
        Api.apiTopicDeCollect,
        params: {
          'accesstoken': params['token'],
          'topic_id': params['id'],
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