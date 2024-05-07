import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class BackgroundItemTile extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  BackgroundItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(I18nContent.background.tr),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // 设置Row的主轴大小为最小
        children: <Widget>[  
          Text(
            I18nContent.value.tr, 
            style: context.textTheme.bodyLarge, // 设置文本样式
          ),
        ],
      ),
      leading: AppIcons.backgroundSelector, // 左侧图标
      onTap: () => _showBackgroundDialog(context), // 点击事件：显示选择弹窗
    );
  }

  // 显示选择弹窗
  Future<void> _showBackgroundDialog(BuildContext context) async {
    final BackgroundController controller = Get.find();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // 设置内容内边距
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: Center(
            child: Text(I18nContent.background.tr),
          ), // 弹窗标题
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: AppIcons.background.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    // Set the selected background here
                    controller.changeBackground(entry.key);
                    // print('Selected background: ${entry.key}');
                    Navigator.of(context).pop();
                  },
                  child: MediaQuery.of(context).orientation ==
                          Orientation.portrait
                      ? Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Image.asset(
                            entry.value,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.6,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey),
                          ),
                          child: Image.asset(
                            entry.value,
                            fit: BoxFit.cover,
                          ),
                        ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
