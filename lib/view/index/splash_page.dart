import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/utils/image_util.dart';
import 'package:flutter_cnode/widget/load_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  List<String> _guideList =  ["app_splash_1", "app_splash_2", "app_splash_3"];
  StreamSubscription _subscription;
  DateTime _lastPressedTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SpUtil.getInstance();
      if (SpUtil.getBool(Config.key_guide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtil.getImageProvider(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) async {
      if (SpUtil.getBool(Config.key_guide, defValue: true)) {
        SpUtil.putBool(Config.key_guide, false);
        _initGuide();
      } else {
        _goIndexPage();
      }
    });
  }

  _goIndexPage() {
    Navigator.of(context).pushReplacementNamed(RouteName.index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedTime == null || DateTime.now().difference(_lastPressedTime) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedTime = DateTime.now();
          return false;
        }
        _goIndexPage();
        return false;
      },
      child: Material(
        child: _status == 0 ? Image.asset(
          ImageUtil.getImgPath('app_splash_0'),
          width: ScreenUtil.getScaleW(context, double.infinity),
          fit: BoxFit.fitWidth,
          height: ScreenUtil.getScaleH(context, double.infinity),
        ) : Swiper(
          key: const Key('swiper'),
          itemCount: _guideList.length,
          loop: false,
          itemBuilder: (_, index) {
            return LoadAssetImage(
              _guideList[index],
              key: Key(_guideList[index]),
              fit: BoxFit.cover,
              width: ScreenUtil.getScaleW(context, double.infinity),
              height: ScreenUtil.getScaleH(context, double.infinity),
            );
          },
          /// 设置 new SwiperPagination() 展示默认分页指示器
          pagination: new SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: RectSwiperPaginationBuilder(
              color: Color(0xFFd3d7de),
              activeColor: Theme.of(context).primaryColor,
              size: Size(21, 3),
              activeSize: Size(21, 3),
              space: 0,
            ),
          ),
          onTap: (index) async {
            if (index == _guideList.length - 1) {
              _goIndexPage();
            }
          },
        )
      ),
    );
  }
}
