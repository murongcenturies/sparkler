import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparkler/core/core.dart';
import 'initial/initial.dart';

class NoteApp extends StatelessWidget {
final ThemeController themeController = Get.put(ThemeController());
  // ignore: prefer_const_constructors_in_immutables
  NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 在调试模式下不显示 Flutter 的调试横幅
      debugShowCheckedModeBanner: false,
      // 使用 DependencyManager 注册依赖
      initialBinding: DependencyManager(),
      // 应用程序的标题
      // title: 'sparkler',

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      
      // 直接调用 getThemeMode() 方法获取当前应用程序的主题模式对应的 ThemeMode
      themeMode: themeController.getThemeMode(),
      // 设置初始路由
      initialRoute: AppRouterName.login.path,
      // 设置应用的路由信息
      getPages: AppRouter.routes,
      // 设置默认路由过渡动画
      defaultTransition: Transition.circularReveal,
      //语言设置
      translations: MyTranslations(), //翻译
      // locale:  Locale(_tranSlationController.currentLanguage.value.toString()..split('.').last), //语言
      locale: const Locale('zh'), //语言
      
    );
    
  }
}

