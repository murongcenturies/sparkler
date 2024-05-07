import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sparkler/core/core.dart';
class LoginController  extends GetxController {
  RxBool isLoading = false.obs;

  // 登录函数
  void signIn(BuildContext context) async {

      isLoading.value = true; // 显示加载动画

      // 模拟登录请求，实际情况应该是调用接口或其他验证逻辑
      await Future.delayed(const Duration(seconds: 1));

      isLoading.value = false; // 隐藏加载动画
      Get.toNamed(AppRouterName.home.path); // 登录成功跳转到首页
  }
}
