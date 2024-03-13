import 'package:demo/model/BottomMenuData.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  //  底部导航栏当前选中项
  final int currentIndex;
  //  底部导航栏Item 列表
  final List<MenuData> menus;
  // 点击事件
  final ValueChanged<int>? onItemTap;

  const AppBottomBar({
    super.key,
    this.currentIndex = 0,
    required this.menus,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onItemTap,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      iconSize: 22,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: menus
          .map(
            (menu) => BottomNavigationBarItem(
              icon: Icon(menu.icon),
              label: menu.label,
            ),
          )
          .toList(),
    );
  }
}
