import 'package:flutter/material.dart';

// 画板顶部tabbar左侧 回退前进按钮
class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons({
    super.key,
    required this.onBack,
    required this.onRevocation,
  });

  @override
  Widget build(BuildContext context) {
    const BoxConstraints cts = BoxConstraints(minHeight: 32, minWidth: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;
    return Center(
      child: Wrap(
        spacing: 1,
        children: [
          IconButton(
            splashRadius: 20,
            onPressed: onBack,
            constraints: cts,
            icon: Icon(
              Icons.arrow_circle_left_outlined,
              color: backColor,
            ),
          ),
          IconButton(
            splashRadius: 20,
            onPressed: onRevocation,
            constraints: cts,
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              color: revocationColor,
            ),
          ),
        ],
      ),
    );
  }
}
