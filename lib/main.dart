import 'package:demo/appNavigation/appNavigation.dart';
import 'package:demo/db/db_storage/db_storage.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DbStorage.instance.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 隐藏debug标识
      title: 'Flutter Demo',
      home: const AppNavigation(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}
