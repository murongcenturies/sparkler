import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparkler/core/core.dart';
import 'package:sparkler/view/home/widgets/grid_view_notes.dart';
import 'package:sparkler/view/home/widgets/header_text.dart';

// 常用笔记视图组件 (用于在不同笔记部分显示笔记列表)
class CommonNotesView extends StatelessWidget {
  // 构造函数
  const CommonNotesView({
    super.key,
    required this.drawerSection, // 笔记部分 (首页、归档、回收站)
    required this.otherNotes, // 其他笔记列表
    required this.pinnedNotes, // 已固定笔记列表
  });

  // 属性
  final DrawerSectionView drawerSection;
  final List<Note> otherNotes;
  final List<Note> pinnedNotes;

  @override
  Widget build(BuildContext context) {
    // 使用 CustomScrollView 构建可滚动列表
    return CustomScrollView(
      slivers: _switchNotesSectionView(drawerSection, otherNotes, pinnedNotes),
      // slivers: 用于构建 Sliver 列表，每个 Sliver 代表可滚动列表的一部分
    );
  }

  // 选择笔记部分并返回对应的 Sliver 列表
  List<Widget> _switchNotesSectionView(DrawerSectionView drawerViewNote,
      List<Note> otherNotes, List<Note> pinnedNotes) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        // 首页：显示已固定笔记和其他笔记
        return [
          // 如果有已固定笔记，则显示 "已固定" 标题
          pinnedNotes.isNotEmpty
              ? HeaderText(text: I18nContent.pinned.tr)
              : const SliverToBoxAdapter(), // 空占位符

          // 以网格形式显示已固定笔记，并允许滑动删除
          GridNotes(notes: pinnedNotes, isShowDismiss: true),

          // 显示 "其他" 标题
          HeaderText(text: I18nContent.other.tr),

          // 以网格形式显示其他笔记，并允许滑动删除
          GridNotes(notes: otherNotes, isShowDismiss: true),

          // 底部留出 120 像素的空间
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ];

      case DrawerSectionView.archive:
      case DrawerSectionView.trash:
      case DrawerSectionView.emotion:
        // 归档和回收站：只显示笔记列表
        return [
          // 以网格形式显示笔记，不显示滑动删除
          GridNotes(notes: otherNotes, isShowDismiss: false),
        ];
    }
  }
}
