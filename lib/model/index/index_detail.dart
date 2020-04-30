import 'package:flustars/flustars.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/provider/view_state/view_state_refresh_list_view_model.dart';
import 'package:flutter_cnode/resp/index/index_resp.dart';

class IndexDetailViewModel extends ViewStateRefreshListViewModel {
  Map indexDetail;

  @override
  Future<List> loadData({int pageNum}) {
    return null;
  }

  Future<Map> findData(String id) async {
    setBusy(true);
    var parm = {
      'id': id,
      'accesstoken': SpUtil.getString(Config.access_token),
    };
    Map data = await IndexResp.findDetail(parm);
    setBusy(false);
    if(data['success']){
      indexDetail = data['data'];
    }else{
      indexDetail = null;
      setError(data['error_msg']);
    }
    return indexDetail;
  }

}