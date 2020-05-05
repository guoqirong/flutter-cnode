import 'package:flutter_cnode/provider/view_state/view_state_refresh_list_view_model.dart';
import 'package:flutter_cnode/resp/index/index_resp.dart';

class IndexModel extends ViewStateRefreshListViewModel {

  @override
  Future<List> loadData({int pageNum}) async {
    Map<String, dynamic> data = await IndexResp.findList(page);
    if(data['success']){
      return data['data'];
    }else{
      return [];
    }
  }
}