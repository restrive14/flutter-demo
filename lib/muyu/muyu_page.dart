import 'dart:math';
import 'package:demo/muyu/animate_text.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:demo/muyu/asset_image.dart';
import 'package:demo/muyu/count_panel.dart';
import 'package:flutter/material.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  // 跳转历史记录页面
  void _toHistory() {}
  // 切换敲击音频
  void _onTapSwitchAudio() {}
  // 切换木鱼图片
  void _onTaoSwitchImage() {}
  // 功德数
  int _counter = 0;
  final Random _random = Random();

  // 当前敲击增加的功德值
  int _cruValue = 0;

  // 敲击木鱼
  void _onKnock() {
    pool?.start();
    setState(() {
      _cruValue = 1 + _random.nextInt(3);
      _counter += _cruValue;
    });
  }

  AudioPool? pool;

  @override
  void initState() {
    super.initState();
    _initAudioPool();
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool(
      'muyu_1.mp3',
      maxPlayers: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('木鱼'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: _toHistory,
            icon: const Icon(Icons.history),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CountPanel(
              count: _counter,
              onTapSwitchAudio: _onTapSwitchAudio,
              onTaoSwitchImage: _onTaoSwitchImage,
            ),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.topCenter,
            children: [
              MuyuAssetsImage(
                image: 'assets/images/muyu.png',
                onTap: _onKnock,
              ),
              if (_cruValue != 0) AnimateText(text: '功德+$_cruValue')
            ],
          ))
        ],
      ),
    );
  }
}
