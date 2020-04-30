import 'package:flutter/material.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton.dart';


class SkeletonUser extends StatelessWidget {
  final int index;

  SkeletonUser({this.index: 0});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(
            context,
            width: 0.7, color: Colors.redAccent
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          index == 0 ? Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 24),
            child: Column(
              children: <Widget>[
                Container(
                  height: 96,
                  width: 96,
                  margin: EdgeInsets.only(bottom: 26),
                  decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
                ),
                Container(
                  height: 20,
                  width: 90,
                  margin: EdgeInsets.only(bottom: 26),
                  decoration: SkeletonDecoration(isDark: isDark),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 28,
                      width: 100,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                    Container(
                      height: 28,
                      width: 100,
                      decoration: SkeletonDecoration(isDark: isDark),
                    ),
                  ],
                ),
              ],
            ),
          ) : SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 20,
                width: 20,
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 100,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 30,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.7,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.8,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 6.5,
                width: width * 0.5,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                height: 8,
                width: 20,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Container(
                height: 8,
                width: 80,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 20,
                width: 20,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
