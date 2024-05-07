// 主题设置列表项
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class AppAbout extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(I18nContent.about.tr), // 标题
      leading: AppIcons.about, // 左侧图标
      onTap: () => _showThemesDialog(context), // 点击事件：显示选择弹窗
    );
  }

  // 显示主题选择弹窗
  Future<void> _showThemesDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // 设置内容内边距
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: Center(
            child: Text(I18nContent.about.tr),
          ), // 弹窗标题
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center( // 添加Center小部件
                child: SizedBox( 
                  width: 200, // 设置宽度
                  child: Text(
                    I18nContent.softwareIntro.tr,
                    style: context.textTheme.bodyLarge,
                    textAlign: TextAlign.center, // 设置文本居中
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
