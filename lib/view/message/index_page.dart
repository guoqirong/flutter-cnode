import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/constants.dart';
import 'package:flutter_cnode/model/message/message_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list_item.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class MessageIndexPage extends StatefulWidget {
  MessageIndexPage({Key key}) : super(key: key);

  @override
  _MessageIndexPageState createState() => _MessageIndexPageState();
}

class _MessageIndexPageState extends State<MessageIndexPage> {
  int tabIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MessageModel>(
      model: MessageModel(),
      onModelReady: (model) {
        model.findMyMessages();
      },
      builder: (context, model, child) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('我的消息'),
              centerTitle: true,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(child: Text('未读')),
                  Tab(child: Text('已读')),
                ],
                onTap: (val) {
                  setState(() {
                    tabIndex = val;
                  });
                },
              ),
            ),
            body: Consumer<MessageModel>(
              builder: (context, model, child) {
                if (model.busy) {
                  return SkeletonList(
                    builder: (context, index) => SkeletonListItem(),
                  );
                } else if (model.error) {
                  return ViewStateWidget(onPressed: () { model.findMyMessages(); });
                } else if (model.empty) {
                  return ViewStateEmptyWidget(onPressed: () { model.findMyMessages(); });
                }
                return TabBarView(
                  children: <Widget>[
                    MessageList(model.messagesData['hasnot_read_messages'], model, isRead: true),
                    MessageList(model.messagesData['has_read_messages'], model, isRead: false),
                  ],
                );
              }
            ),
            floatingActionButton: tabIndex == 0 && int.parse(SpUtil.getString('messageCount')) > 0 ? FlatButton(
              color: Colors.blue,
              child: Text('全部已读', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              onPressed: () async {
                var data = await model.markAllMessages();
                if (data['success']) {
                  model.findMyMessages();
                }
              },
            ) : SizedBox(),
          ),
        );
      }
    );
  }
}

class MessageList extends StatefulWidget {
  final List data;
  final bool isRead;
  final MessageModel model;
  const MessageList(this.data, this.model, {this.isRead:true, Key key}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: List<Widget>.from(widget.data.map((v) {
        var dataContent = v['reply']['content'].replaceAll(new RegExp(r'\bsrc\b\s*=\s*["]?//'), ' src="http://');
        return Column(
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
                margin: EdgeInsets.only(right: 10, bottom: 10),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(v['author']['avatar_url']),
                ),
              ),
              title: Text(v['author']['loginname'] + '回复了您的话题'),
              subtitle: Text(DateUtil.formatDate(DateUtil.getDateTime(v['create_at']), format: 'yyyy-MM-dd')??Constants.empty_string),
              trailing: widget.isRead ? FlatButton(
                color: Colors.blue[100],
                child: Text('已读', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  var data = await widget.model.markOneMessages(v['id']);
                  if (data['success']) {
                    widget.model.findMyMessages();
                  }
                }
              ) : SizedBox(),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Html(
                data: dataContent,
                useRichText: true,
                defaultTextStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '话题：',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(v['topic']['title'])
                ],
              ),
            ),
          ],
        );
      })).toList(),
    );
  }
}
