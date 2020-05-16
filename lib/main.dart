import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cnode/model/index/index_model.dart';
import 'package:flutter_cnode/routers/router.dart';
import 'package:flutter_cnode/widget/provider_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance();
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: Consumer<IndexModel>(
          builder: (context, indexModel, child) {
            return RefreshConfiguration(
              hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
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
                initialRoute: RouteName.splash,
              )
            );
          }
        )
      ),
    );
  }
}
