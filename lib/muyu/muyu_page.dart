import 'dart:math';
import 'package:demo/model/AudioOption.dart';
import 'package:demo/model/ImageOption.dart';
import 'package:demo/muyu/animate_text.dart';
import 'package:demo/muyu/audio_option_panel.dart';
import 'package:demo/muyu/image_option_panel.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:demo/muyu/asset_image.dart';
import 'package:demo/muyu/count_panel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

class _MuyuPageState extends State<MuyuPage> {
  // 功德数
  int _counter = 0;
  final Random _random = Random();

  // 当前敲击增加的功德值
  int _cruValue = 0;

  // 木鱼样式列表
  final List<ImageOption> imageOptions = const [
    ImageOption(name: '基础版', src: 'assets/images/muyu.png', min: 1, max: 3),
    ImageOption(name: '尊享版', src: 'assets/images/muyu2.png', min: 3, max: 6),
  ];
  // 选中的木鱼样式索引
  int _activeImageIndex = 0;
  // 音频
  AudioPool? pool;

  // 音频列表
  final List<AudioOption> audioOptions = const [
    AudioOption(name: '音效1', src: 'muyu_1.mp3'),
    AudioOption(name: '音效2', src: 'muyu_2.mp3'),
    AudioOption(name: '音效3', src: 'muyu_3.mp3'),
  ];
  // 选中的音频索引
  int _activeAudioIndex = 0;

  // 切换音频
  void _onSelectAudio(int value) {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex) return;
    _activeAudioIndex = value;
    _initAudioPool('${audioOptions[value].src}');
  }

  // 音频初始化
  void _initAudioPool(String src) async {
    pool = await FlameAudio.createPool(
      src,
      maxPlayers: 4,
    );
  }

  // 跳转历史记录页面
  void _toHistory() {}
  // 切换敲击音频
  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return AudioOptionPanel(
          audioOptions: audioOptions,
          activeIndex: _activeAudioIndex,
          onSelect: _onSelectAudio,
        );
      },
    );
  }

  // 切换木鱼图片
  void _onTapSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return ImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _onSelectImage,
        );
      },
    );
  }

  // 点击了木鱼样式 切换样式
  _onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  // 敲击木鱼
  void _onKnock() {
    pool?.start();
    int? min = imageOptions[_activeImageIndex].min;
    int? max = imageOptions[_activeImageIndex].max;
    setState(() {
      _cruValue = min! + _random.nextInt(max! - min + 1);
      _counter += _cruValue;
    });
  }

  @override
  void initState() {
    super.initState();
    _initAudioPool('${audioOptions[_activeAudioIndex].src}');
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
              onTapSwitchImage: _onTapSwitchImage,
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuAssetsImage(
                  image: '${imageOptions[_activeImageIndex].src}',
                  onTap: _onKnock,
                ),
                if (_cruValue != 0) AnimateText(text: '功德+$_cruValue'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
