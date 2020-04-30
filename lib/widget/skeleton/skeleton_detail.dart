import 'package:flutter/material.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton.dart';


class SkeletonDetail extends StatelessWidget {
  final int index;

  SkeletonDetail({this.index: 0});

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 40,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 160,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 50,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 120,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 60,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 180,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 70,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 200,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 90,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 110,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 40,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 190,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.redAccent,
                  width: 1,
                )
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                height: 5,
                width: 20,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
              Expanded(child: SizedBox.shrink()),
              Container(
                height: 5,
                width: 240,
                decoration: SkeletonDecoration(isDark: isDark),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
