import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/core.dart';
import './widgets/widgets.dart';
import 'widgets/about.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

// 设置页面
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BackgroundController controller = Get.find();
    return Scaffold(
        // 页面顶部应用栏
        appBar: AppBar(
          title: Text(I18nContent.set.tr), // 标题为 “设置”
        ),
        body: Stack(
          children: [
            // 添加背景图片
            Obx(() => Positioned.fill(
                  child: Stack(
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                controller.selectedBackground.isNotEmpty
                                    ? controller.selectedBackground
                                    : AppIcons.cloud),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            color: Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(0.5), // 使用主题背景颜色
                          ),
                        ),
                      ),
                      PlasmaRenderer(
  type: PlasmaType.infinity,
  particles: 10,
  color: Color(0x440fbcdf),
  blur: 0.4,
  size: 0.79,
  speed: 1,
  offset: 0,
  blendMode: BlendMode.screen,
  particleType: ParticleType.atlas,
  variation1: 0,
  variation2: 0,
  variation3: 0,
  rotation: 0,
)
                    ],
                  ),
                )),
            Material(
              color: Colors.transparent, // 设置 Material 颜色为透明
              child: Sections(
                // 分区列表
                sections: [
                  // 标题为 “显示选项” 的分块，包含一个 “主题” 项目
                  TilesSection(
                    title: I18nContent.display.tr,
                    tiles: [ThemesItemTile()],
                    background: [BackgroundItemTile()],
                    about: [AppAbout()],
                    children: [TranslationItemTile()],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
