import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/constants.dart';
import 'package:flutter_cnode/model/collect/collect_model.dart';
import 'package:flutter_cnode/model/index/index_detail_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_detail.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_html/flutter_html.dart';

class IndexViewDetailPage extends StatefulWidget {
  final String id;
  final String pageTitle;
  IndexViewDetailPage(this.id, {Key key, this.pageTitle:"话题详情" }):super(key: key);

  @override
  _IndexViewDetailPageState createState() => _IndexViewDetailPageState();
}

class _IndexViewDetailPageState extends State<IndexViewDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(widget.pageTitle),
        centerTitle: true,
      ),
      body: ProviderWidget<IndexDetailModel>(
        model: IndexDetailModel(),
        onModelReady: (model) => model.findData(widget.id),
        builder: (context, model, child) {
          if (model.busy) {
            return SkeletonList(
              builder: (context, index) => SkeletonDetail(),
            );
          } else if (model.error) {
            return ViewStateWidget(onPressed: () { model.findData(widget.id); });
          } else if (model.empty) {
            return ViewStateEmptyWidget(onPressed: () { model.findData(widget.id); });
          }
          var content = model.indexDetail['content'].replaceAll(new RegExp(r'\bsrc\b\s*=\s*["]?//'), ' src="http://');
          return ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[200])),
                ),
                child: ListTile(
                  title: Text(
                    model.indexDetail['title']??Constants.empty_string,
                    style: TextStyle(
                      fontSize: ScreenUtil.getScaleSp(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(DateUtil.formatDate(DateUtil.getDateTime(model.indexDetail['create_at']), format: 'yyyy-MM-dd')??Constants.empty_string),
                  trailing: IconButton(
                    icon: Icon(
                      model.indexDetail['is_collect'] ? Icons.star : Icons.star_border,
                      color: model.indexDetail['is_collect'] ? Colors.orange : null,
                    ),
                    onPressed: () async {
                      if (model.indexDetail['is_collect']) {
                        var data = await CollectModel().deCollectTopic(model.indexDetail['id']);
                        if (data['success']) {
                          setState(() {
                            model.indexDetail['is_collect'] = !model.indexDetail['is_collect'];
                          });
                        }
                      } else {
                        var data = await CollectModel().collectTopic(model.indexDetail['id']);
                        if (data['success']) {
                          setState(() {
                            model.indexDetail['is_collect'] = !model.indexDetail['is_collect'];
                          });
                        }
                      }
                    }
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[200])),
                ),
                child: Html(
                  data: content,
                  useRichText: true,
                  defaultTextStyle: TextStyle(
                    fontSize: ScreenUtil.getScaleSp(context, 14.0),
                    color: Colors.black,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              model.indexDetail['replies'] != null && model.indexDetail['replies'].length > 0 ? ListTile(
                title: Text(
                  '评论',
                  style: TextStyle(
                    fontSize: ScreenUtil.getScaleSp(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ) : SizedBox(),
              Column(
                children: model.indexDetail['replies'] != null && model.indexDetail['replies'].length > 0 ? List<Widget>.from(model.indexDetail['replies'].map((v) {
                  var repliesContent = v['content'].replaceAll(new RegExp(r'\bsrc\b\s*=\s*["]?//'), ' src="http://');
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[200])),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            width: ScreenUtil.getScaleW(context, 36),
                            height: ScreenUtil.getScaleH(context, 36),
                            margin: EdgeInsets.only(right: 10, bottom: 10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(v['author']['avatar_url']),
                            ),
                          ),
                          title: Text(v['author']['loginname'] + '回复了您的话题'),
                          subtitle: Text(DateUtil.formatDate(DateUtil.getDateTime(v['create_at']), format: 'yyyy-MM-dd')??Constants.empty_string),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          child: Html(
                            data: repliesContent,
                            useRichText: true,
                            defaultTextStyle: TextStyle(
                              fontSize: ScreenUtil.getScaleSp(context, 14.0),
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })).toList() : <Widget>[],
              ),
            ],
          );
        }
      ),
    );
  }
}