import 'package:flutter/material.dart';

class PaintPaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;

  const PaintPaperAppBar({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.rotate_left_outlined),
          Icon(Icons.rotate_right_outlined)
        ],
      ),
      title: const Text(
        '画板绘制',
        style: TextStyle(fontSize: 16),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: onClear,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
