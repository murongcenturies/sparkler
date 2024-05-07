import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparkler/core/core.dart';
import 'personal_info_form.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// 创建一个列表来存储所有的提示
List<String> hints = [
  I18nContent.hint,
  I18nContent.hint1,
  I18nContent.hint2,
  I18nContent.hint3,
  I18nContent.hint4,
];
double getTextSize(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double textSize = screenWidth * 0.01; // 计算原始大小
  if (textSize < 18.0) {
    textSize = 18.0; // 最小值
  } else if (textSize > 30.0) {
    textSize = 28.0; // 最大值
  }
  return textSize;
}

// 全局变量来跟踪当前显示的提示的索引
int currentHintIndex = 0;

/// 自定义个人信息对话框
Future<void> personalInfoDialog(BuildContext context,
    {ValueChanged? onClosed}) async {
  await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: I18nContent.personalInfo.tr,
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween =
            Tween(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
            position: tween.animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
            child: child);
      },
      pageBuilder: (context, _, __) {
        final size = MediaQuery.of(context).size;
        const double dialogHeight = 500;
        final double dialogWidth = size.width > 600 ? 600 : size.width;

        return Center(
          child: Container(
            height: dialogHeight,
            width: dialogWidth,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.95),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      Text(
                        I18nContent.personalInfo.tr,
                        style: const TextStyle(
                          fontSize: 34,
                        ),
                      ),
                      const PersonalInfoForm(),
                      const Divider(),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child:
                                // Text(
                                //     // 显示当前的提示
                                //   hints[currentHintIndex].tr,
                                //   style: const TextStyle(fontSize: 18),
                                // ),
                                AnimatedTextKit(
                              // pause: const Duration(milliseconds: 100),
                              repeatForever: true,
                              pause: Duration.zero, // 消除延迟
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  hints[currentHintIndex].tr,
                                  textStyle:
                                      TextStyle(fontSize: getTextSize(context)),
                                  colors: [
                                    const Color(0xFFD8E7CB),
                                    Colors.red.shade200,
                                    Colors.orange,
                                    Colors.blue,
                                    Colors.indigo,
                                    Colors.purple.shade100,
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
  if (onClosed != null) {
    onClosed(null);
  }
  // 更新当前的提示索引，如果已经到达列表的末尾，就回到列表的开始
  currentHintIndex = (currentHintIndex + 1) % hints.length;
}
