# flutter_cnode

A new Flutter cnode project.

## 1. Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 2.运行环境
flutter v1.9.1+hotfix.2

## 2.运行、打包命令
运行：flutter run
打包：flutter build apk --target-platform android-arm64 或 flutter build apk

## 4. 目录结构
```
|
├── android                android配置文件
├── assets                 项目静态资源
├── lib                    源码目录
|   ├── config             项目配置文件
|   ├── model              控制页面数据变化的模型
|   ├── provider           页面与模型交互的摸块
|   ├── resp               数据接口访问摸块
|   ├── routers            页面路由摸块
|   ├── utils              公共方法库
|   ├── view               页面文件目录
|   ├── widget             公用组件
|   └── main.dart          项目入口文件
├── pubspec.yaml           资源包配置文件
└── README.md              项目说明
```

## 5.效果图


![首页](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/index.png)

![登录](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/login.png)

![菜单1](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/menu1.png)

![菜单2](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/menu2.png)

![个人中心](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/personal.png)

![详情](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/detail.png)

![消息](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/message.png)

![收藏](https://github.com/guoqirong/taro-cnode/blob/master/demo-screenshot/collect.png)