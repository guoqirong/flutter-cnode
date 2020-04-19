class Config {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = const bool.fromEnvironment("dart.vm.product");

  static const String app_title = "Flutter Cnode";

  static bool isTest  = false;

  static const String base_url = inProduction ? "https://cnodejs.org" : "https://cnodejs.org";

  static const String code_base_port = "";

  static const String gateway_url = base_url + code_base_port;
  
  static const String access_token = 'accessToken';
  
  static const String key_guide = 'key_guide';
}