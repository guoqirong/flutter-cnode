import 'package:flustars/flustars.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/provider/view_state/view_state_refresh_list_view_model.dart';
import 'package:flutter_cnode/resp/message/message_resp.dart';

class MessageModel extends ViewStateRefreshListViewModel {
  Map messagesData;
  int messageCount;

  @override
  Future<List> loadData({int pageNum}) async {
    return [];
  }

  Future<int> findMessageCount({String token}) async {
    Map<String, dynamic> data = await MessageResp.findMeaaageCount(token);
    if(data['success']){
      messageCount = data['data'];
      SpUtil.putString('messageCount', data['data'].toString()); // 持久化到本地
      return data['data'];
    }else{
      return null;
    }
  }

  Future<Map> findMyMessages() async {
    setBusy(true);
    Map data = await MessageResp.findMyMessages({'token': SpUtil.getString(Config.access_token)});
    setBusy(false);
    if(data['success']){
      messagesData = data['data'];
      return data['data'];
    }else{
      setError(data['error_msg']);
      return data;
    }
  }
  
  Future<Map> markAllMessages() async {
    var params = {
      'token': SpUtil.getString(Config.access_token),
    };
    Map data = await MessageResp.markAllMessages(params);
    if(data['success']){
      return data;
    }else{
      setError(data['error_msg']);
      return data;
    }
  }

  Future<Map> markOneMessages(String id) async {
    var params = {
      'id': id,
      'token': SpUtil.getString(Config.access_token),
    };
    Map data = await MessageResp.markOneMessages(params);
    if(data['success']){
      return data;
    }else{
      setError(data['error_msg']);
      return data;
    }
  }
}