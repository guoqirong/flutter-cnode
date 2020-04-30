import 'package:flustars/flustars.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/provider/view_state/view_state_refresh_list_view_model.dart';
import 'package:flutter_cnode/resp/user/user_resp.dart';

class UserModel extends ViewStateRefreshListViewModel {
  String token;
  Map userDate;
  int messageCount;

  @override
  Future<List> loadData({int pageNum}) async {
    return [];
  }

  Future<Map> findAccesstoken({String token}) async {
    Map<String, dynamic> data = await UserResp.findAccesstoken(token);
    if(data['success']){
      token = token;
      SpUtil.putString(Config.access_token, token); // 持久化到本地
      SpUtil.putObject('userSimpleDate', data); // 持久化到本地
      await findMessageCount(token: token);
      return data;
    }else{
      return null;
    }
  }

  Future<Map> findUserDate({String userName}) async {
    setBusy(true);
    Map<String, dynamic> data = await UserResp.findUserData(userName);
    setBusy(false);
    if(data['success']){
      userDate = data['data'];
      return data;
    }else{
      return null;
    }
  }

  Future<int> findMessageCount({String token}) async {
    Map<String, dynamic> data = await UserResp.findUserMeaaageCount(token);
    if(data['success']){
      messageCount = data['data'];
      SpUtil.putString('messageCount', data['data'].toString()); // 持久化到本地
      return data['data'];
    }else{
      return null;
    }
  }
}