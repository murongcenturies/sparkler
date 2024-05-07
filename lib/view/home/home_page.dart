import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'widgets/widgets.dart';
import 'package:sparkler/core/core.dart';
import 'package:sparkler/view/views.dart';
import 'package:metaballs/metaballs.dart';
import 'package:get/get.dart';

// 主页 (显示所有笔记列表)
class HomePage extends StatelessWidget {
  // HomePage({super.key});

  final DrawerNavigationController drawerController =
      Get.put(DrawerNavigationController());
  final HomeController homeController = Get.put(HomeController());
  final PasswordsController passwordController = Get.put(PasswordsController());
  final StatusIconsController noteStatue = Get.put(StatusIconsController());
  final EmotionController emotionController = Get.put(EmotionController());
  late final NoteController _controller;
  HomePage({super.key}) {
    // 获取当前选中的视图
    final selectedView = drawerController
        .convertToDrawerSectionView(drawerController.selectedNavItem.value);
    // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // 初始化 NoteController 并将其放入 GetX 管理
    _controller = Get.put(NoteController(selectedView), tag: name);
  }

  @override
  Widget build(BuildContext context) {
    final BackgroundController controller = Get.find();

    return Scaffold(
      //自定义windows_bar
      appBar: CustomAppBar(title: I18nContent.title.tr),
      // 抽屉导航
      drawer: const AppDrawer(),
      // 浮动操作按钮 (用于新增笔记)
      floatingActionButton: _buildFloatingActionButton(context),
      // 显示 ParallaxRain 效果
      body: Stack(
        children: <Widget>[
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
                    Metaballs(
                      color: const Color.fromARGB(
                          255, 66, 133, 244), // 设置 Metaballs 的颜色
                      effect: MetaballsEffect.follow(
                        growthFactor: 1, // 设置 Metaballs 的生长因子
                        smoothing: 1, // 设置 Metaballs 的平滑度
                        radius: 0.5, // 设置 Metaballs 的半径
                      ),
                      gradient: const LinearGradient(colors: [
                        // 设置 Metaballs 的渐变色
                        Color.fromARGB(255, 90, 60, 255),
                        Color.fromARGB(255, 230, 200, 255),
                        Color.fromARGB(255, 120, 255, 255),
                        Color.fromARGB(255, 166, 211, 15),
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                      metaballs: 40, // 设置 Metaballs 的数量
                      animationDuration: const Duration(
                          milliseconds: 200), // 设置 Metaballs 的动画持续时间
                      speedMultiplier: 1, // 设置 Metaballs 的速度倍数
                      bounceStiffness: 3, // 设置 Metaballs 的弹跳刚度
                      minBallRadius: 15, // 设置 Metaballs 的最小半径
                      maxBallRadius: 40, // 设置 Metaballs 的最大半径
                      glowRadius: 0.7, // 设置 Metaballs 的发光半径
                      glowIntensity: 0.6, // 设置 Metaballs 的发光强度
                    ),
                  ],
                ),
              )),
          // 根据状态显示不同的组件
          Obx(() {
            final state = _controller.noteState.value;
            _controller.refreshNotes();
            if (state is LoadingState) {
              return CommonLoadingNotes(state.drawerSectionView);
            } else if (state is EmptyNoteState) {
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is ErrorState) {
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is NotesViewState) {
              return SliverNotes(
                child: CommonNotesView(
                  drawerSection: DrawerSectionView.home,
                  otherNotes: state.otherNotes,
                  pinnedNotes: state.pinnedNotes,
                ),
              );
            }
            displayNotesMsg(state);
            // 默认返回空占位符
            return const SizedBox.shrink();
          }),
          // ),
        ],
      ),
    );
  }

  void displayNotesMsg(state) {
    if (state is SuccessState) {
      // 刷新笔记列表并显示成功信息
      _controller.refreshNotes();
      // print(state.message);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackbarMsg(Get.context!, state.message);
      });
    } else if (state is ToggleSuccessState) {
      // print(state.message);
      // 显示可撤销操作的 Snackbar
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackarUndoMove(Get.context!, state.message);
        _controller.refreshNotes();
      });
    } else if (state is EmptyInputsState) {
      // 显示空输入提示信息
      AppAlerts.displaySnackbarMsg(Get.context!, state.message);
    } else if (state is GoPopNoteState) {
      // 刷新笔记列表
      _controller.refreshNotes();
    } else if (state is GetNoteByIdState) {
      // print(state.note);
      // 处理获取单个笔记信息的逻辑
      _getNoteByIdState(state.note);
    }
  }

  // 处理获取单个笔记信息的逻辑
  void _getNoteByIdState(Note note) {
    Future.delayed(Duration.zero, () {
      // 更新图标状态
      noteStatue.toggleIconsStatus(note);
      emotionController.toggleEmotionIconsStatus(note, note.emotion);
      passwordController.togglePasswords(note, note.password, note.isEncrypted);
    });
    // print('--${note.password},--${note.isEncrypted}');
    // print(passwordController.currentPasswordsState);
    // 导航到笔记详情页面
    // Get.toNamed(AppRouterName.note.path, arguments: note);
    _navigateToNoteDetail(note);
  }

  void _navigateToNoteDetail(Note note) async {
    await Future.delayed(Duration.zero);
    Get.toNamed(
      AppRouterName.note.path,
      arguments: {
        'note': note,
        'noteController': _controller,
      },
    );
  }

  // 构建浮动操作按钮
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        // 去掉阴影
        elevation: 0,
        child: AppIcons.add,
        // 点击时添加新笔记
        onPressed: () {
          _controller.getById(''); // 获取空白笔记
        });
  }
}
