import 'package:demo/appBottomBar/appBottomBar.dart';
import 'package:demo/guess/guess_page.dart';
import 'package:demo/model/BottomMenuData.dart';
import 'package:demo/muyu/muyu_page.dart';
import 'package:demo/paintPaper/paint_page.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  //  底部导航栏当前选中项
  int _index = 0;

  //  底部导航栏Item 列表
  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
  ];

  // 页面控制器
  final PageController _ctrl = PageController();

  // 切换页面
  void _onChangePage(int index) {
    _ctrl.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
      bottomNavigationBar: AppBottomBar(
        currentIndex: _index,
        onItemTap: _onChangePage,
        menus: menus,
      ),
    );
  }

  // 构建可切换页面
  Widget _buildPage() {
    return PageView(
      controller: _ctrl,
      physics: const ClampingScrollPhysics(),
      onPageChanged: (value) {
        setState(() {
          _index = value;
        });
      },
      children: const [
        GuessPage(),
        MuyuPage(),
        PaintPaper(),
      ],
    );
  }
}
