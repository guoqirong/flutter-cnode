import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/constants.dart';
import 'package:flutter_cnode/model/user/user_model.dart';
import 'package:flutter_cnode/provider/provider_widget.dart';
import 'package:flutter_cnode/provider/view_state/view_state_widget.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_list.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton_user.dart';

class UserIndexPage extends StatefulWidget {
  UserIndexPage({Key key}) : super(key: key);

  @override
  _UserIndexPageState createState() => _UserIndexPageState();
}

class _UserIndexPageState extends State<UserIndexPage> {
  int changIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心')),
      body: ProviderWidget<UserModel>(
        model: UserModel(),
        onModelReady: (model) => model.findUserDate(userName: SpUtil.getObject('userSimpleDate')['loginname']),
        builder: (context, model, child) {
          if (model.busy) {
            return SkeletonList(
              builder: (context, index) => SkeletonUser(index: index),
            );
          } else if (model.error) {
            return ViewStateWidget(onPressed: model.initData);
          } else if (model.empty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          }
          return Column(
            children: <Widget>[
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor.withAlpha(200),
                padding: EdgeInsets.only(top: 24),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 96,
                      width: 96,
                      margin: EdgeInsets.only(bottom: 16),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(model.userDate['avatar_url']??''),
                      ),
                    ),
                    Text(
                      model.userDate['loginname']??Constants.empty_string,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 56,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[400])),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          changIndex = 1;
                        });
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 2 - 1,
                        alignment: Alignment.center,
                        child: Text('我的话题', style: TextStyle(fontSize: 18)),
                        decoration: changIndex == 1 ? BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: Colors.blue)),
                        ) : null,
                      ),
                    ),
                    SizedBox(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(right: BorderSide(width: 1, color: Colors.blueGrey[200])),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          changIndex = 2;
                        });
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width / 2 - 1,
                        alignment: Alignment.center,
                        child: Text('我的回复', style: TextStyle(fontSize: 18)),
                        decoration: changIndex == 2 ? BoxDecoration(
                          border: Border(bottom: BorderSide(width: 2, color: Colors.blue)),
                        ) : null,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: changIndex == 1 ? Column(
                  children: List<Widget>.from(model.userDate['recent_topics'].map((v) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[200])),
                      ),
                      child: ListTile(
                        title: Text(v['title']??Constants.empty_string),
                        subtitle: Text(DateUtil.formatDate(DateUtil.getDateTime(v['last_reply_at']), format: 'yyyy-MM-dd')??Constants.empty_string),
                      ),
                    );
                  })).toList(),
                ) : Column(
                  children: List<Widget>.from(model.userDate['recent_replies'].map((v) {
                    return  Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: Colors.blueGrey[200])),
                      ),
                      child: ListTile(
                        title: Text(v['title']??Constants.empty_string),
                        subtitle: Text(DateUtil.formatDate(DateUtil.getDateTime(v['last_reply_at']), format: 'yyyy-MM-dd')??Constants.empty_string),
                      ),
                    );
                  })).toList(),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}