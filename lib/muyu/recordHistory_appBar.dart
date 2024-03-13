// 顶部AppBar Widget
import 'package:flutter/material.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback clearHistory;
  final bool deleted;
  const HistoryAppBar(this.clearHistory, {super.key, this.deleted = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // 返回数据到第一个页面
          Navigator.pop(context, deleted);
        },
      ),
      title: const Text(
        '功德记录',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [
        IconButton(
          onPressed: clearHistory,
          icon: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
