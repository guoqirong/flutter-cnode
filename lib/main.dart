import 'package:flutter/material.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/view/index/index_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Cnode',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        locale: Locale("zh", "CN"),
        localizationsDelegates: const [
          RefreshLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('zh'),
        ],
        onGenerateRoute: Router.generateRoute,
        // initialRoute: RouteName.index,
        home: IndexPage(),
      ),
    );
  }
}
