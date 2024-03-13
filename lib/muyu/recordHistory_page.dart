import 'package:demo/model/MeritRecord.dart';
import 'package:demo/muyu/recordHistory_appBar.dart';
import 'package:flutter/material.dart';

class RecordHistoryPage extends StatefulWidget {
  final List<MeritRecord> records;
  const RecordHistoryPage({super.key, required this.records});
  @override
  State<RecordHistoryPage> createState() => _RecordHistoryPageState();
}

class _RecordHistoryPageState extends State<RecordHistoryPage> {
  // 是否清除历史记录
  late bool deleted = false;
  // 清除功德记录
  void clearHistory() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('提示'),
        content: const Text('是否清除历史记录?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                widget.records.clear();
                deleted = true;
              });
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HistoryAppBar(
        clearHistory,
        deleted: deleted,
      ),
      body: ListView.builder(
        itemCount: widget.records.length,
        itemBuilder: (context, index) {
          return _buildItem(index);
        },
      ),
    );
  }

  // 历史记录Item
  Widget _buildItem(int index) {
    final date =
        DateTime.fromMillisecondsSinceEpoch(widget.records[index].timestamp);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(widget.records[index].image),
      ),
      title: Text('功德 + ${widget.records[index].value}'),
      subtitle: Text(widget.records[index].audio),
      trailing: Text(
        '$date',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
    );
  }
}
