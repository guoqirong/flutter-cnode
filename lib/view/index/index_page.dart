import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cnode/config/constants.dart';
import 'package:flutter_cnode/model/index/index_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/utils/toast_util.dart';
import 'package:flutter_cnode/view/index/drawer/index.dart';
import 'package:flutter_cnode/widget/animated/refresh_animatedlist.dart';
import 'package:flutter_cnode/widget/refresh.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title:'全部'}) : super(key: key);
  final String title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin {
  final GlobalKey<SliverAnimatedListState> listKey = GlobalKey<SliverAnimatedListState>();
  String title;
  DateTime _lastPressedTime;
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<IndexModel>(
      model: IndexModel(),
      onModelReady: (model) {
        model.page['filterMap'] = {'tab': 'all'};
        model.initData();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(this.title??widget.title),
          ),
          drawer: Drawer(
            child: MyDrawer(
              onClickTab: (val) {
                setState(() {
                  title = val == 'good' ? '精华' : val == 'share' ? '分享' :
                  val == 'ask' ? '问答' : val == 'job' ? '招聘' : val == 'dev' ? '客户端测试' : '全部';
                });
                model.page['filterMap'] = {'tab': val};
                model.initData();
              },
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (_lastPressedTime == null ||
                  DateTime.now().difference(_lastPressedTime) > Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                _lastPressedTime = DateTime.now();
                ToastUtil.show("再次点击退出应用", duration: 1000);
                return false;
              }
              ToastUtil.cancelToast();
              SystemNavigator.pop();
              return false;
            },
            child: Consumer<IndexModel>(
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
                  header: CommonRefreshHeader(),
                  footer: CommonRefreshFooter(),
                  onRefresh: () async {
                    await model.refresh();
                    listKey.currentState.refresh(model.list.length);
                  },
                  onLoading: () async {
                    await model.loadMore();
                    listKey.currentState.refresh(model.list.length);
                  },
                  enablePullUp: true,
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAnimatedList(
                        key: listKey,
                        initialItemCount: model.list.length,
                        itemBuilder: (context, index, animation) {
                          var item = model.list[index];
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[],
                            child: SizeTransition(
                              axis: Axis.vertical,
                              sizeFactor: animation,
                              child: IndexListItemWidget(
                                item,
                              )
                            ),
                          );
                        }
                      )
                    ],
                  ),
                );
              }
            ),
          ),
        );
      }
    );
  }
}

class IndexListItemWidget extends StatelessWidget {
  final item;
  IndexListItemWidget(this.item);
  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    /// 用于Hero动画的标记
    // UniqueKey uniqueKey = UniqueKey();
    return Stack(
      children: <Widget>[
        Material(
          color: backgroundColor,
          child: InkWell(
            onTap: () {
              var arguments = {
                'id': item['id']
              };
              Navigator.of(context).pushNamed(RouteName.index_detail, arguments: arguments);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context, width: 1),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 48,
                        height: 48,
                        margin: EdgeInsets.only(right: 10, bottom: 10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(item['author']['avatar_url']),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 14),
                          child: Text(
                            item['title']??Constants.empty_string,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 14),
                        child: Text(
                          item['reply_count'] != null ? item['reply_count'].toString() : Constants.empty_string,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 48,
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            // ( item.tab === 'job' ? 'lightpink' : item.tab === 'dev' ? 'lightgray' : '')
                            color: item['top'] ? Color.fromARGB(255, 240, 128, 128) :
                              item['tab'] == 'share' ? Color.fromARGB(255, 50, 205, 50) :
                              item['tab'] == 'ask' ? Color.fromARGB(255, 32, 178, 170) :
                              item['tab'] == 'job' ? Color.fromARGB(255, 255, 182, 193) :
                              item['tab'] == 'dev' ? Color.fromARGB(255, 211, 211, 211) : Color.fromARGB(255, 173, 216, 230),
                          ),
                          color: item['top'] ? Color.fromARGB(255, 240, 128, 128) :
                            item['tab'] == 'share' ? Color.fromARGB(255, 50, 205, 50) :
                            item['tab'] == 'ask' ? Color.fromARGB(255, 32, 178, 170) :
                            item['tab'] == 'job' ? Color.fromARGB(255, 255, 182, 193) :
                            item['tab'] == 'dev' ? Color.fromARGB(255, 211, 211, 211) : Color.fromARGB(255, 173, 216, 230),
                        ),
                        child: Text(
                          item['top'] ? '置顶' : item['tab'] == 'share' ? '分享' : item['tab'] == 'ask' ? '问答' :
                            item['tab'] == 'job' ? '招聘' : item['tab'] == 'dev' ? '客户端测试' : '精华',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          DateUtil.formatDate(DateUtil.getDateTime(item['create_at']), format: 'yyyy-MM-dd')??Constants.empty_string,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          item['visit_count'] != null ? item['visit_count'].toString() : Constants.empty_string,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}