import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/menu_drawer_item.dart';
import 'package:sparkler/core/core.dart';
import './widgets/drawer.dart';

/// 表示应用程序抽屉的小部件。
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawerNavigationController>(
      builder: (controller) => Drawer(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context), // 构建抽屉的标题部分
                  _buildTextLogo(context), // 构建抽屉的文本标志部分
                  const MenuDrawerItem(DrawerViews.home), // 构建抽屉的主页菜单项
                  const Divider(), // 构建抽屉的分割线
                  const MenuDrawerItem(DrawerViews.archive), // 构建抽屉的存档菜单项
                  const MenuDrawerItem(DrawerViews.trash), // 构建抽屉的垃圾桶菜单项
                  const MenuDrawerItem(DrawerViews.emotion), // 构建抽屉的情绪菜单项
                  const MenuDrawerItem(DrawerViews.setting), // 构建抽屉的设置菜单项
                  const Divider(), // 构建抽屉的分割线
                ],
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: _buildBottomLeft(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建抽屉的标题部分。
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  /// 构建抽屉的文本标志部分。
  Widget _buildTextLogo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: I18nContent.drawer.tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
          ],
        ),
      ),
    );
  }

  /// 构建抽屉的底部左侧部分
  Widget _buildBottomLeft(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomLeft,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.pop(context); // 关闭抽屉
            personalInfoDialog(context);
          },
        ),
      ),
    );
  }
}
