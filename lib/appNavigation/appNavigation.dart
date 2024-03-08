import 'package:demo/appBottomBar/appBottomBar.dart';
import 'package:demo/guess/guess_page.dart';
import 'package:demo/model/BottomMenuData.dart';
import 'package:demo/muyu/muyu_page.dart';
import 'package:demo/paintPaper/paint_page.dart';
import 'package:demo/paintPaper/paper_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;

  //  底部导航栏Item 列表
  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
  ];

  // 切换页面
  void _onChangePage(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildPage(_index)),
        AppBottomBar(
          menus: menus,
          currentIndex: _index,
          onItemTap: _onChangePage,
        )
      ],
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const GuessPage();
      case 1:
        return const MuyuPage();
      case 2:
        return const PaintPaper();
      default:
        return const SizedBox.shrink();
    }
  }
}
