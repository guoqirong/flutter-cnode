import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 通用列表的header
class CommonRefreshHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicHeader(
      idleText: "下拉可刷新",
      releaseText: "释放可刷新",
      refreshingText: "刷新中",
      completeText: "刷新完成",
      textStyle: TextStyle(color: Theme.of(context).primaryColor),
    );
  }
}

/// 通用的footer
class CommonRefreshFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      failedText: "加载失败,请点击重试",
      idleText: "上拉加载更多",
      loadingText: "加载中...",
      noDataText: "没有更多数据了",
    );
  }
}
