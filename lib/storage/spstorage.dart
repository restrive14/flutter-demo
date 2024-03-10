import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String kGuessSpKey = 'guess-config';

class SpStorage {
  SpStorage._(); //私有化构造

  static SpStorage? _storage;

  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;
  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  // 存储猜数字数据状态
  Future<bool> saveGuess({
    required bool guessing,
    required int value,
  }) async {
    await initSpWhenNull();
    String content = json.encode({'guessing': guessing, 'value': value});
    return _sp!.setString(kGuessSpKey, content);
  }

  // 读取猜数字数据状态
  Future<Map<String, dynamic>> readGuessConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }
}
