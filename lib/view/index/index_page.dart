import 'package:flutter/material.dart';
import 'package:flutter_cnode/model/index/index_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list_item.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title:'全部'}) : super(key: key);
  final String title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<IndexModel>(
      model: IndexModel(),
      onModelReady: (model) {
        print(model);
        // model.page.sortKey = "sortOrder";
        // model.page.sortValue = "descending";
        // if(filterMap!=null){
        //   model.page..filterMap = filterMap;
        // }
        // if (!(UserModel().isAuth("spms:corpfill:mine:add") || UserModel().isAuth("spms:corpfill:mine:update") || UserModel().isAuth("spms:corpfill:mine:delete"))) {
        //   var filter = {'state': 1};
        //   model.page.filterMap = filter;
        // }
        model.initData();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(widget.title),
          ),
          body: Consumer<IndexModel>(
            builder: (context, model, child) {
              if (model.busy) {
                return SkeletonList(
                  builder: (context, index) => SkeletonListItem(),
                );
              } else if (model.error) {
                return ViewStateWidget(onPressed: model.initData);
              } else if (model.empty) {
                return ViewStateEmptyWidget(onPressed: model.initData);
              }
              return SmartRefresher(
                controller: model.refreshController,
                // header: CommonRefreshHeader(),
                // footer: CommonRefreshFooter(),
                // onRefresh: model.refresh,
                // onLoading: model.loadMore,
                onRefresh: () async {
                  await model.refresh();
                  // listKey.currentState.refresh(model.list.length);
                },
                onLoading: () async {
                  await model.loadMore();
                  // listKey.currentState.refresh(model.list.length);
                },
                enablePullUp: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                  ],
                ),
              );
            }
          ),
        );
      }
    );
  }
}