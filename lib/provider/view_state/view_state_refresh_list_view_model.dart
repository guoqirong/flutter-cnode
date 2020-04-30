import 'package:flutter/foundation.dart';
import 'package:flutter_cnode/provider/view_state/view_state_list_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 基于
abstract class ViewStateRefreshListViewModel extends ViewStateListViewModel {
  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  static const int pageSize = 20;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  Map page = { 'page': 1, 'limit': 20,};

  resetPage() {
    page['page'] = pageNumFirst;
    if(page['filterMap'] == null){
      page['filterMap'] = new Map<String, dynamic>();
    }else{
      page['filterMap'].clear();
    }
    list = [];
  }

  /// 下拉刷新
  Future<List> refresh({bool init = false}) async {
    try {
      page['page'] = pageNumFirst;
      page['list'] = list;
      var data = await loadData(pageNum: pageNumFirst);
      if (data != null) {
        if (data.isEmpty) {
          setEmpty();
          refreshController.refreshCompleted();
          refreshController.loadNoData();
          notifyListeners();
        } else {
          onCompleted(data);
          list.clear();
          list.addAll(data);
          refreshController.refreshCompleted();
          if (data.length < page['limit']) {
            refreshController.loadNoData();
          } else {
            //防止上次上拉加载更多失败,需要重置状态
            refreshController.loadComplete();
          }
          if (init) {
            //改变页面状态为非加载中
            setBusy(false);
          } else {
            notifyListeners();
          }
        }
      }
      return data;
    } catch (e, s) {
      handleCatch(e, s);
      return null;
    }
  }

  /// 上拉加载更多
  Future<List> loadMore() async {
    try {
      var data = await loadData(pageNum: ++page['page']);
      if (data.isEmpty) {
        page['page']--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < page['limit']) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      page['page']--;
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<List> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
