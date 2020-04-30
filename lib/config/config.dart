class Config {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = const bool.fromEnvironment("dart.vm.product");
  // 默认标题
  static const String app_title = "Flutter Cnode";
  // 测试模式
  static bool isTest  = false;
  // 后端接口地址域名或ip地址
  static const String base_url = inProduction ? "https://cnodejs.org" : "https://cnodejs.org";
  // 后端接口地址端口
  static const String code_base_port = "";
  // 后端接口地址
  static const String gateway_url = base_url + code_base_port;
  // 登录验证标识名称
  static const String access_token = 'accessToken';
  // 首次安装标识名称
  static const String key_guide = 'key_guide';
}