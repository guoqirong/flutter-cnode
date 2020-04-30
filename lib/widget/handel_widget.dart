
import 'package:flutter/material.dart';
import 'package:flutter_cnode/config/config.dart';
import 'package:flutter_cnode/utils/image_util.dart';
import 'package:flutter_cnode/widget/style/gaps.dart';
import 'package:flutter_svg/svg.dart';

class PageNotFoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //isBack: false,
        title: Text(Config.app_title),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              ImageUtil.getImgSvgPath("hint"),
              width: 80,
              height: 80,
            ),
            Gaps.vGap16,
            Text(
              "访问的页面不存在。"
            ),
            Gaps.vGap50,
          ],
        ),
      ),
    );
  }
}

class PageBuildingWidget extends StatelessWidget {
  final bool automaticallyImplyLeading;

  PageBuildingWidget({this.automaticallyImplyLeading:true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Text(Config.app_title),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              ImageUtil.getImgSvgPath("hint"),
              width: 80,
              height: 80,
            ),
            Gaps.vGap16,
            Text(
                "页面功能建设中。"
            ),
            Gaps.vGap50,
          ],
        ),
      ),
    );
  }
}