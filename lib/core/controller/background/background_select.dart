import 'package:get/get.dart';

import '../../core.dart';

enum AppBackgrounds {
  werow,
  cloud,
  cassie,
  nature,
}

class BackgroundController extends GetxController {
  final _selectedBackground = AppBackgrounds.werow.obs;

 String get selectedBackground => AppIcons.background[_selectedBackground.value] ?? '';

  void changeBackground(AppBackgrounds background) {
    _selectedBackground.value = background;
  }
}
