import 'package:get/get.dart';

import '../../core.dart';

// 情绪图标状态类
class PasswordsState {
  // 构造函数
  const PasswordsState();
}

// 情绪图标初始状态
class PasswordsInitial extends PasswordsState {}

// 切换情绪图标状态
class TogglePasswordsState extends PasswordsState {
  // 当前笔记对象
  final Note currentNote;
  // 当前密码状态
  final String currentPasswords;
  //当前加密状态
  final bool currentIsEncrypted;

  // 构造函数
  const TogglePasswordsState({
    required this.currentNote,
    required this.currentPasswords,
    required this.currentIsEncrypted,
  });
}

class PasswordsController extends GetxController {
  // 当前笔记对象
  final _currentNote = Note.empty().obs;
  // 当前密码状态
  final RxString _currentPasswords = ''.obs;
  //当前加密状态
  final RxBool _currentIsEncrypted = false.obs;

  // 当前图标状态
  final Rx<PasswordsState> _currentPasswordsState =
      Rx<PasswordsState>(PasswordsInitial());

  //获取当前密码图标状态
  get currentPasswords => _currentPasswords;
  get currentIsEncrypted => _currentIsEncrypted;
  get currentPasswordsState => _currentPasswordsState;

  // 切换密码图标状态
  void togglePasswords(
      Note currentNote, String currentPasswords, bool currentIsEncrypted) {
    _currentNote.value = currentNote;
    _currentPasswords.value = currentPasswords;
    _currentIsEncrypted.value = currentIsEncrypted;
    _currentPasswordsState.value = TogglePasswordsState(
      currentNote: _currentNote.value,
      currentPasswords: _currentPasswords.value,
      currentIsEncrypted: _currentIsEncrypted.value,
    );
    // print('this is ${_currentPasswords.value}');
    // print(currentNote);
    update();
  }
}
