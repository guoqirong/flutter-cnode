import 'package:flutter_cnode/provider/view_state/view_state_view_model.dart';

/// 基于
abstract class ViewStateListViewModel extends ViewStateViewModel {
  /// 页面数据
  List list = [];

  /// 第一次进入页面loading skeleton
  initData() async {
    setBusy(true);
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      List data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list = data;
        if (init) {
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } catch (e, s) {
      handleCatch(e, s);
    }
  }

  // 加载数据
  Future<List> loadData();

  onCompleted(List data) {}
}
