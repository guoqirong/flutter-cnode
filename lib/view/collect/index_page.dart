import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/constants.dart';
import 'package:flutter_cnode/model/collect/collect_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/widget/animated/refresh_animatedlist.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CollectIndexPage extends StatefulWidget {
  CollectIndexPage({Key key}) : super(key: key);

  @override
  _CollectIndexPageState createState() => _CollectIndexPageState();
}

class _CollectIndexPageState extends State<CollectIndexPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<CollectModel>(
      model: CollectModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('我的收藏')),
          body: Consumer<CollectModel>(
            builder: (context, model, child) {
              if (model.busy) {
                return SkeletonList(
                  builder: (context, index) => SkeletonListItem(index: index),
                );
              } else if (model.error) {
                return ViewStateWidget(onPressed: model.initData);
              } else if (model.empty) {
                return ViewStateEmptyWidget(onPressed: model.initData);
              }
              print(model.list);
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAnimatedList(
                    initialItemCount: model.list.length,
                    itemBuilder: (context, index, animation) {
                      var item = model.list[index];
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        secondaryActions: <Widget>[],
                        child: SizeTransition(
                          axis: Axis.vertical,
                          sizeFactor: animation,
                          child: CollectListItemWidget(
                            item,
                          )
                        ),
                      );
                    }
                  )
                ],
              );
            }
          ),
        );
      }
    );
  }
}

class CollectListItemWidget extends StatelessWidget {
  final item;
  CollectListItemWidget(this.item);
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
              Navigator.of(context).pushNamed(RouteName.index_detail, arguments: item['id']);
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
                        width: ScreenUtil.getScaleW(context, 36),
                        height: ScreenUtil.getScaleH(context, 36),
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
                              fontSize: ScreenUtil.getScaleSp(context, 18),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, bottom: 14),
                        child: Text(
                          item['reply_count'] != null ? item['reply_count'].toString() : Constants.empty_string,
                          style: TextStyle(
                            fontSize: ScreenUtil.getScaleSp(context, 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.getScaleW(context, 36),
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
                            fontSize: ScreenUtil.getScaleSp(context, 12),
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
                            fontSize: ScreenUtil.getScaleSp(context, 14),
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text(
                          item['visit_count'] != null ? item['visit_count'].toString() : Constants.empty_string,
                          style: TextStyle(
                            fontSize: ScreenUtil.getScaleSp(context, 12),
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