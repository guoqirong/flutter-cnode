import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/utils/image_util.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uuid/uuid.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  ViewStateWidget({
    Key key,
    this.image,
    this.message,
    this.buttonText,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //image ?? Icon(Icons.error, size: 80, color: Colors.grey[500]),
          image ?? SvgPicture.asset(
            ImageUtil.getImgSvgPath("hint"),
            width: 80,
            height: 80,
            color: Colors.orange,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 150),
            child: Text(
              message ?? "加载失败",
              style: Theme.of(context).textTheme.body1.copyWith(color: Colors.grey),
            ),
          ),
          ViewStateButton(
            child: buttonText,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateEmptyWidget({
    Key key,
    this.image,
    this.message,
    this.buttonText,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? const Icon(
        Icons.autorenew,
        size: 100,
        color: Colors.grey,
      ),
      message: message ?? '暂无数据',
      buttonText: buttonText ?? Text(
        '刷新一下',
        style: TextStyle(letterSpacing: 5),
      ),
    );
  }
}


/// 页面无权限查看数据
class ViewStateEmptyPermissionWidget extends StatelessWidget {
  final String message;

  const ViewStateEmptyPermissionWidget({
    Key key,
    this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 48,
            color: Theme.of(context).buttonColor,
          ),
          SizedBox(height: 12,),
          Text(message??'无权限查看数据'),
        ],
      ),
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String message;
  final Widget image;
  final Widget buttonText;
  final VoidCallback onPressed;

  const ViewStateUnAuthWidget({
    Key key,
    this.image,
    this.message,
    this.buttonText,
    @required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? ViewStateUnAuthImage(),
      message: message ?? '未登录',
      buttonText: buttonText ?? Text(
        '登录',
        style: TextStyle(wordSpacing: 5),
      ),
    );
  }
}

/// 未授权图片
class ViewStateUnAuthImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'loginLogo${Uuid().v4()}',
      child: Image.asset(
        ImageUtil.getImgPath('login_logo'),
        width: 130,
        height: 100,
        fit: BoxFit.fitWidth,
        color: Theme.of(context).accentColor,
        colorBlendMode: BlendMode.srcIn,
      ),
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const ViewStateButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ?? Text(
        '重试',
        style: TextStyle(wordSpacing: 5),
      ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}




