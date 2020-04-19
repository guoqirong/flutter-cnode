import 'package:flutter_cnode/config/config.dart';

class Api {
  // 主题
  static final String apiTopics = Config.gateway_url + '/api/v1/topics';
  static final String apiTopic = Config.gateway_url + '/api/v1/topic/';

  // 主题收藏
  static final String apiTopicCollect = Config.gateway_url + '/api/v1/topic_collect/collect';
  static final String apiTopicDeCollect = Config.gateway_url + '/api/v1/topic_collect/de_collect';
  static final String apiTopicCollectList = Config.gateway_url + '/api/v1/topic_collect/';

  // 用户
  static final String apiUser = Config.gateway_url + '/api/v1/user/';
  static final String apiAccesstoken = Config.gateway_url + '/api/v1/accesstoken';

  // 消息通知
  static final String apiMessageCount = Config.gateway_url + '/api/v1/message/count';
  static final String apiMessage = Config.gateway_url + '/api/v1/messages';
  static final String apiMessageCountMarkall = Config.gateway_url + '/api/v1/message/mark_all';
  static final String apiMessageCountMmarkone = Config.gateway_url + '/api/v1/message/mark_one/';
}