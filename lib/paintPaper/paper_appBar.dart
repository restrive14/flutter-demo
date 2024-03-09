import 'package:demo/paintPaper/backUpButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaintPaperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onClear;

  final VoidCallback? onBack;

  final VoidCallback? onRevocation;

  const PaintPaperAppBar({
    super.key,
    required this.onClear,
    this.onBack,
    this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: BackUpButtons(
        onBack: onBack,
        onRevocation: onRevocation,
      ),
      leadingWidth: 120,
      title: const Text(
        '画板绘制',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          splashRadius: 20,
          icon: const Icon(
            Icons.delete_outlined,
            color: Colors.black,
            size: 20,
          ),
          onPressed: onClear,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
