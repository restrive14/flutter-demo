import 'package:demo/model/Line.dart';
import 'package:demo/paintPaper/paper_appBar.dart';
import 'package:demo/paintPaper/paper_painter.dart';
import 'package:flutter/material.dart';

class PaintPaper extends StatefulWidget {
  const PaintPaper({super.key});

  @override
  State<PaintPaper> createState() => _PaintPaperState();
}

class _PaintPaperState extends State<PaintPaper> {
  //线列表
  List<Line> _lines = [];
  // 颜色激活索引
  int _activeColorIndex = 0;
  // 线宽激活索引
  int _activeStorkWidthIndex = 0;

  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  void _clear() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('提示'),
              content: const Text('是否清除画板?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('取消')),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    setState(() {
                      _lines.clear();
                    });
                  },
                  child: const Text('确定'),
                ),
              ],
            ));
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(Line(
      points: [details.localPosition],
    ));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _lines.last.points.add(details.localPosition);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaintPaperAppBar(onClear: _clear),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: CustomPaint(
          painter: PaperPainter(lines: _lines),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
          ),
        ),
      ),
    );
  }
}
