import 'dart:math';

import 'package:demo/guess/guess_appbar.dart';
import 'package:demo/guess/result_notice.dart';
import 'package:flutter/material.dart';

class GuessPage extends StatefulWidget {
  final String title;
  const GuessPage({super.key, required this.title});

  @override
  State<GuessPage> createState() => _GuessPageState();
}

class _GuessPageState extends State<GuessPage> {
  // 随机数
  int _value = 0;
  Random _random = Random();

  // 判断是不是正在猜测中
  bool _guessing = false;

  // 判断结果是不是相同  null 相等  true 大了  false 小了
  bool? _isBig;

  // text输入框控制器
  TextEditingController _guessCtrl = TextEditingController();

  // 生成随机数
  void _generateRandomValue() {
    setState(() {
      _guessing = true;
      _value = _random.nextInt(100);
    });
  }

  // 进行猜测
  void _onCheck() {
    print('$_value');
    int? guessValue = int.tryParse(_guessCtrl.text);
    if (!_guessing || guessValue == null) return;
    if (guessValue == _value) {
      setState(() {
        _isBig = null;
        _guessing = false;
      });
      return;
    }
    setState(() {
      _isBig = guessValue > _value;
    });
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
                    '点击生成随机数值',
                  ),
                Text(
                  _guessing ? '**' : '$_value',
                  style: Theme.of(context).textTheme.headlineMedium,
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
}
