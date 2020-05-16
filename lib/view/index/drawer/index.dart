import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/model/message/message_model.dart';
import 'package:flutter_cnode/model/user/user_model.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/utils/image_util.dart';
import 'package:flutter_cnode/utils/toast_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class MyDrawer extends StatefulWidget {
  final onClickTab;
  MyDrawer({Key key, this.onClickTab}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  UserModel model = UserModel();
  var userSimpleData;

  @override
  initState() {
    userSimpleData = SpUtil.getObject('userSimpleDate');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        InkWell(
          onTap: () async {
            if (SpUtil.getString(Config.access_token) == '') {
              await Navigator.of(context).pushNamed(RouteName.login_form);
              setState(() {
                userSimpleData = SpUtil.getObject('userSimpleDate');
              });
            } else {
              Navigator.of(context).pushNamed(RouteName.user_index);
            }
          },
          child: UserAccountsDrawerHeader(
            accountName: Text(userSimpleData != null ? userSimpleData['loginname'] : '请登录Cnode社区'),
            accountEmail: Text(''),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(userSimpleData != null ? userSimpleData['avatar_url'] : ''),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageUtil.getImgPath('user_bg', format: 'jpg')),
              )
            ),
            otherAccountsPictures: <Widget>[
              SpUtil.getString(Config.access_token) == '' ? IconButton(
                icon: SvgPicture.asset(
                  ImageUtil.getImgSvgPath('scan'),
                  color: Colors.white,
                ),
                onPressed: () async {
                  String barcode = await scanner.scan();
                  ToastUtil.show("登录中，请稍后...");
                  if (barcode != null) {
                    var data = await model.findAccesstoken(token: barcode);
                    if (data['success']) {
                      ToastUtil.show("登录成功");
                      setState(() {
                        userSimpleData = SpUtil.getObject('userSimpleDate');
                      });
                    } else {
                      ToastUtil.show("登录失败，请稍后重试！");
                    }
                  }
                  // await _showSelectSheet(context);
                  // setState(() {
                  //   userSimpleData = SpUtil.getObject('userSimpleDate');
                  // });
                },
              ) : IconButton(
                icon: Icon(
                  Icons.input,
                  color: Colors.white,
                ),
                onPressed: () {
                  showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('全部'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('all');
          },
        ),
        ListTile(
          leading: Icon(Icons.grade),
          title: Text('精华'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('good');
          },
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('分享'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('share');
          },
        ),
        ListTile(
          leading: Icon(Icons.question_answer),
          title: Text('问答'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('ask');
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('招聘'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('job');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('客户端测试'),
          onTap: () {
            Navigator.pop(context);
            widget.onClickTab('dev');
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.notifications),
          title: Text('我的消息'),
          trailing: Container(
            width: ScreenUtil.getScaleW(context, SpUtil.getString('messageCount').isNotEmpty && SpUtil.getString('messageCount') != '0' ? 40 : 24),
            child: Row(
              children: <Widget>[
                Text(SpUtil.getString('messageCount').isNotEmpty && SpUtil.getString('messageCount') != '0' ? SpUtil.getString('messageCount') : ''),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () async {
            if (SpUtil.getString(Config.access_token) != null && SpUtil.getString(Config.access_token) != '') {
              await Navigator.of(context).pushNamed(RouteName.message_index);
              await MessageModel().findMessageCount(token: SpUtil.getString(Config.access_token));
              setState(() { });
            } else {
              await Navigator.of(context).pushNamed(RouteName.login_form);
              setState(() {
                userSimpleData = SpUtil.getObject('userSimpleDate');
              });
            }
          },
        ),
      ],
    );
  }
  
  showLogoutDialog(BuildContext context)  {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('退出'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('是否确定退出本账号？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('确定'),
              onPressed: () {
                SpUtil.remove(Config.access_token);
                SpUtil.remove('userSimpleDate');
                SpUtil.remove('messageCount');
                setState(() {
                  userSimpleData = null;
                });
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  
  // // 弹出底部选择(扫码\选图片)
  // Future<int> _showSelectSheet(BuildContext context) {
  //   return showModalBottomSheet<int>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: ScreenUtil.getScaleH(context, 116),
  //         child: ListView(
  //           children: <Widget>[
  //             ListTile(
  //               title: Text('扫码'),
  //               onTap: () async {
  //                 String barcode = await scanner.scan();
  //                 ToastUtil.show("登录中，请稍后...");
  //                 if (barcode != null) {
  //                   var data = await model.findAccesstoken(token: barcode);
  //                   if (data['success']) {
  //                     ToastUtil.show("登录成功");
  //                     Navigator.pop(context, 1);
  //                   } else {
  //                     ToastUtil.show("登录失败，请稍后重试！");
  //                   }
  //                 }
  //               },
  //             ),
  //             ListTile(
  //               title: Text('选图片'),
  //               onTap: () async {
  //                 String barcode = await scanner.scanPhoto();
  //                 ToastUtil.show("登录中，请稍后...");
  //                 if (barcode != null) {
  //                   var data = await model.findAccesstoken(token: barcode);
  //                   if (data['success']) {
  //                     ToastUtil.show("登录成功");
  //                     Navigator.pop(context, 1);
  //                   } else {
  //                     ToastUtil.show("登录失败，请稍后重试！");
  //                   }
  //                 }
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   );
  // }
}