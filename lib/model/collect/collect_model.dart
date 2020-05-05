import 'package:flustars/flustars.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/provider/view_state/view_state_refresh_list_view_model.dart';
import 'package:flutter_cnode/resp/collect/collect_resp.dart';

class CollectModel extends ViewStateRefreshListViewModel {

  @override
  Future<List> loadData({int pageNum}) async {
    Map<String, dynamic> data = await CollectResp.findList(SpUtil.getObject('userSimpleDate')['loginname']);
    if(data['success']){
      return data['data'];
    }else{
      return [];
    }
  }

  Future<Map> collectTopic(String id) async {
    setBusy(true);
    var params = {
      'id': id,
      'token': SpUtil.getString(Config.access_token),
    };
    Map data = await CollectResp.collectTopic(params);
    setBusy(false);
    if(data['success']){
      return data;
    }else{
      setError(data['error_msg']);
      return data;
    }
  }

  Future<Map> deCollectTopic(String id) async {
    setBusy(true);
    var params = {
      'id': id,
      'token': SpUtil.getString(Config.access_token),
    };
    Map data = await CollectResp.deCollectTopic(params);
    setBusy(false);
    if(data['success']){
      return data;
    }else{
      setError(data['error_msg']);
      return data;
    }
  }
}