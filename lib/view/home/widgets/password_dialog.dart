import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class PasswordDialog extends StatelessWidget {
  final Note note; // 笔记数据
  final TextEditingController passwordController = TextEditingController();
  // ignore: prefer_const_constructors_in_immutables
  PasswordDialog({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 圆角
      ),
      title: Text(
        I18nContent.enterPassword.tr,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
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
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            // print(passwordController);
            Navigator.of(context).pop(passwordController.text);
          },
        ),
      ],
    );
  }
}
