import 'package:flutter_cnode/resp/api.dart';
import 'package:flutter_cnode/utils/dio_resp.dart';

class UserResp {
  static Future<Map<String, dynamic>> findAccesstoken(token) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.post,
        Api.apiAccesstoken,
        queryParameters: {
          'accesstoken': token,
        },
        isList: false
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> findUserData(userName) async {
    try {
      var data = await DioUtils().requestNetwork(
        Method.get,
        '${Api.apiUser}$userName',
        isList: false
      );
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>> findUserMeaaageCount(token) async {
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
}