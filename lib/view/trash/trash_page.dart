import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sparkler/view/home/widgets/widgets.dart';
import 'package:sparkler/core/core.dart';
import 'package:sparkler/view/views.dart';
import 'package:get/get.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

import 'app_bar_trash.dart';

// 主页 (显示所有笔记列表)
class TrashPage extends StatelessWidget {
  // HomePage({super.key});
  final DrawerNavigationController drawerController =
      Get.put(DrawerNavigationController());
  final StatusIconsController noteStatue = Get.put(StatusIconsController());
  final EmotionController emotionController = Get.put(EmotionController());
  late final NoteController _controller;
  TrashPage({super.key}) {
    final selectedView = drawerController
        .convertToDrawerSectionView(drawerController.selectedNavItem.value);
    // print(selectedView);
    // 获取视图名称
    String name = selectedView.toString().split('.').last;
    // 初始化 NoteController 并将其放入 GetX 管理
    _controller = Get.put(NoteController(selectedView), tag: name);
  }

  @override
  Widget build(BuildContext context) {
    final BackgroundController controller = Get.find();
    return Scaffold(
      appBar: const AppBarTrash(),
      // 抽屉导航
      drawer: const AppDrawer(),
      // 显示 ParallaxRain 效果
      body: Stack(
        children: <Widget>[
          // 添加背景图片
          Obx(() => Positioned.fill(
                  child: Stack(children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(controller.selectedBackground.isNotEmpty
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
                const PlasmaRenderer(
                  type: PlasmaType.bubbles,
                  particles: 25,
                  color: Color(0x44249de4),
                  blur: 0.11,
                  size: 0.16,
                  speed: 1.86,
                  offset: 0.74,
                  blendMode: BlendMode.screen,
                  particleType: ParticleType.atlas,
                  variation1: 0.31,
                  variation2: 0.3,
                  variation3: 0.13,
                  rotation: 2.12,
                ),
              ]))),
          // 根据状态显示不同的组件
          Obx(() {
            final state = _controller.noteState.value;
            _controller.refreshNotes();
            displayNotesMsg(state);
            // print(state);
            if (state is LoadingState) {
              // print(state);
              return CommonLoadingNotes(state.drawerSectionView);
            } else if (state is EmptyNoteState) {
              // print(state.drawerSectionView);
              // return const CommonEmptyNotes(DrawerSectionView.home);
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is ErrorState) {
              // print(state);
              return CommonEmptyNotes(state.drawerSectionView);
            } else if (state is NotesViewState) {
              return Padding(
                padding: const EdgeInsets.only(top: 10.0), // 顶部边距
                child: CommonNotesView(
                  drawerSection: DrawerSectionView.trash,
                  otherNotes: state.otherNotes,
                  pinnedNotes: const [], // 回收站不展示置顶笔记
                ),
              );
            }
            // 默认返回空占位符
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

// 处理笔记状态变化
  void displayNotesMsg(state) {
    if (state is SuccessState) {
      // 刷新笔记列表并显示成功信息
      _controller.refreshNotes();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        AppAlerts.displaySnackbarMsg(Get.context!, state.message);
      });
    } else if (state is GoPopNoteState) {
      // 返回上一页：刷新笔记列表
      _controller.refreshNotes();
    } else if (state is GetNoteByIdState) {
      // 获取指定笔记详情
      _getNoteByIdState(state.note);
    }
  }

  // 处理获取单个笔记信息的逻辑
  void _getNoteByIdState(Note note) {
    Future.delayed(Duration.zero, () {
      // 更新图标状态
      noteStatue.toggleIconsStatus(note);
      emotionController.toggleEmotionIconsStatus(note, note.emotion);
    });

    // 导航到笔记详情页面
    _navigateToNoteDetail(note);
  }

// 导航到笔记详情页面
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
}
