import 'package:flutter/material.dart';
import 'package:flutter_cnode/widget/skeleton/skeleton.dart';


class SkeletonDetail extends StatelessWidget {
  final int index;

  SkeletonDetail({this.index: 0});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(right: 10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width - 140,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: 60,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ],
              ),
              Container(
                height: 36,
                width: 36,
                margin: EdgeInsets.only(bottom: 26),
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
            ],
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
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 160,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 200,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 320,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 160,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 200,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 320,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 160,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 200,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 320,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 200,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            decoration: SkeletonDecoration(isDark: isDark),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 5,
            width: 320,
            decoration: SkeletonDecoration(isDark: isDark),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 36,
                width: 36,
                margin: EdgeInsets.only(bottom: 26),
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width - 140,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: 60,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ],
              ),
            ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 36,
                width: 36,
                margin: EdgeInsets.only(bottom: 26),
                decoration: SkeletonDecoration(isCircle: true, isDark: isDark),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: MediaQuery.of(context).size.width - 140,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 5,
                    width: 60,
                    decoration: SkeletonDecoration(isDark: isDark),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
