import 'package:demo/model/MeritRecord.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordHistoryPage extends StatelessWidget {
  final List<MeritRecord> records;
  RecordHistoryPage({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        '功德记录',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  Widget _buildItem(int index) {
    final date = DateTime.fromMillisecondsSinceEpoch(records[index].timestamp);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(records[index].image),
      ),
      title: Text('功德 + ${records[index].value}'),
      subtitle: Text(records[index].audio),
      trailing: Text('$date',
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}
