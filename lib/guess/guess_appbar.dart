import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onCheck;
  final TextEditingController controller;
  const GuessAppBar(
      {super.key, required this.onCheck, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      // leading: const Icon(
      //   Icons.menu,
      //   color: Colors.black,
      // ),
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xffF3F6F9),
            constraints: BoxConstraints(maxHeight: 35),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide.none),
            hintText: "输入0~99数字",
            hintStyle: TextStyle(fontSize: 14)),
      ),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: onCheck,
          icon: const Icon(
            Icons.run_circle_outlined,
            color: Colors.blue,
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
