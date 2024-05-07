import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/core.dart';

// 笔记页面 “密码” 按钮
class IconPasswordsStatus extends StatelessWidget {
  final Note note;
  // ignore: prefer_const_constructors_in_immutables, use_super_parameters
  IconPasswordsStatus({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordsController>(
      builder: (controller) {
        final currentStatus = controller.currentIsEncrypted.value;

        return IconButton(
          icon: Icon(iconCurrentStatus(currentStatus)),
          color: Theme.of(context).iconTheme.color,
          onPressed: () {
            _onTogglePasswordsStatus(context);
          },
          tooltip: currentStatus == true
              ? I18nContent.lock.tr
              : I18nContent.unlock.tr,
        );
      },
    );
  }

  IconData iconCurrentStatus(bool currentIsEncrypted) {
    if (currentIsEncrypted == true) {
      return AppIcons.lock;
    } else {
      return AppIcons.unlock;
    }
  }

  void _onTogglePasswordsStatus(BuildContext context) {
    final PasswordsController currentPasswords =
        Get.find<PasswordsController>();
    if (currentPasswords.currentIsEncrypted == false) {
      showDialog(
        context: context,
        builder: (context) {
          final TextEditingController passwordController =
              TextEditingController();
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 圆角
            ),
            title: Text(
              I18nContent.enterPassword.tr,
            ),
            content: TextField(
              controller: passwordController,
              obscureText: true,
              maxLength: 6, // 限制密码长度为6
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // 输入框圆角
                ),
                filled: true,
                fillColor: Colors.grey[200], // 输入框背景色
                contentPadding: const EdgeInsets.all(12), // 输入框内边距
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  I18nContent.ok.tr,
                ),
                onPressed: () {
                  currentPasswords
                      .togglePasswords(note, passwordController.text,true);
                  Navigator.pop(context);}
              ),
            ],
          );
        },
      );
    } else {
      currentPasswords.togglePasswords(note, '',false);
    }
  }
}
