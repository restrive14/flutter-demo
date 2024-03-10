import 'dart:math';

import 'package:demo/guess/guess_appbar.dart';
import 'package:demo/guess/result_notice.dart';
import 'package:demo/storage/spstorage.dart';
import 'package:flutter/material.dart';

class GuessPage extends StatefulWidget {
  const GuessPage({super.key});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  // 随机数
  int _value = 0;
  final Random _random = Random();

  // 判断是不是正在猜测中
  bool _guessing = false;

  // 判断结果是不是相同  null 相等  true 大了  false 小了
  bool? _isBig;

  // text输入框控制器
  final TextEditingController _guessCtrl = TextEditingController();

  // 生成随机数
  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _value = _random.nextInt(100);
      // 存储到本地
      SpStorage.instance.saveGuess(guessing: _guessing, value: _value);
    });
  }

  // 进行猜测
  void _onCheck() {
    // print('$_value');
    int? guessValue = int.tryParse(_guessCtrl.text);
    if (!_guessing || guessValue == null) return;
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      // 存储到本地
      SpStorage.instance.saveGuess(guessing: _guessing, value: 0);
      return;
    }
    setState(() {
      _isBig = guessValue > _value;
    });
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readGuessConfig();
    _guessing = config['guessing'] ?? false;
    _value = config['value'] ?? 0;
    setState(() {});
  }

  @override
  void initState() {
    _initConfig();
  }

  @override
  void dispose() {
    _guessCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuessAppBar(
        onCheck: _onCheck,
        controller: _guessCtrl,
      ),
      body: Stack(
        children: [
          if (_isBig != null)
            Column(
              children: [
                if (_isBig!)
                  const ResultNotice(color: Colors.blueAccent, info: '大了'),
                const Spacer(),
                if (!_isBig!)
                  const ResultNotice(color: Colors.redAccent, info: '小了'),
              ],
            ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_guessing)
                  const Text(
                    '点击右下角按钮生成随机数值',
                  ),
                Text(
                  _guessing ? '**' : '恭喜你猜对了，结果是$_value',
                  style: const TextStyle(fontSize: 20, color: Colors.blue),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guessing ? null : _generateRandomValue,
        backgroundColor: _guessing ? Colors.grey : Colors.blue,
        tooltip: 'Increment',
        child: const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();
}
