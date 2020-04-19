import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cnode/view/index/index_page.dart';
import 'package:flutter_cnode/view/index/splash_page.dart';
import 'package:flutter_cnode/widget/handel_widget.dart';
import 'package:flutter_cnode/widget/route/animated_page_route.dart';

class RouteName {
  static const String splash = '/view/index/splash_page';
  static const String index = '/view/index/index_page';
  static const String nav = '/view/nav/nav_page';
}

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.index:
        return CupertinoPageRoute(fullscreenDialog: true, builder: (_) => IndexPage());
      
      default:
        print(settings.name);
        return CupertinoPageRoute(fullscreenDialog: true, builder: (_) => PageNotFoundWidget());
    }
  }
}

class OtherDetailFormPage {
}
/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
  Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

class DialogRoute extends PageRouteBuilder{

  final Widget page;

  DialogRoute(this.page) : super(
    opaque: false,
    barrierColor: Colors.grey,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}

class RouteOption{
  String url;
  Map<String, dynamic> query;
  RouteOption(this.url, this.query);
}