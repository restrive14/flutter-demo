import 'package:demo/model/Line.dart';
import 'package:demo/paintPaper/colorSelector.dart';
import 'package:demo/paintPaper/paper_appBar.dart';
import 'package:demo/paintPaper/paper_painter.dart';
import 'package:demo/paintPaper/storkWidthSelector.dart';
import 'package:flutter/material.dart';

class PaintPaper extends StatefulWidget {
  const PaintPaper({super.key});

  @override
  State<PaintPaper> createState() => _PaintPaperState();
}

class _PaintPaperState extends State<PaintPaper>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //线列表
  List<Line> _lines = [];
  // 颜色激活索引
  int _activeColorIndex = 0;
  // 线宽激活索引
  int _activeStorkWidthIndex = 0;
  // 支持选择的颜色列表
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
  // 支持选择的线条宽度列表
  final List<double> supportStorkWidths = [1, 2, 4, 6, 8, 10];

  final List<Line> _historyLines = [];

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
            child: const Text('取消'),
          ),
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
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(Line(
      points: [details.localPosition],
      strokeWidth: supportStorkWidths[_activeStorkWidthIndex],
      color: supportColors[_activeColorIndex],
    ));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    Offset point = details.localPosition;
    double distance = (_lines.last.points.last - point).distance;
    if (distance < 5) {
      return;
    }
    _lines.last.points.add(details.localPosition);
    setState(() {});
  }

  void _onSelectStorkWidth(int index) {
    if (index != _activeStorkWidthIndex) {
      setState(() {
        _activeStorkWidthIndex = index;
      });
    }
  }

  void _onSelectColor(int index) {
    if (index != _activeColorIndex) {
      setState(() {
        _activeColorIndex = index;
      });
    }
  }

  void _back() {
    Line line = _lines.removeLast();
    _historyLines.add(line);
    setState(() {});
  }

  void _revocation() {
    Line line = _historyLines.removeLast();
    _lines.add(line);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaintPaperAppBar(
        onClear: _clear,
        onBack: _lines.isEmpty ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: PaperPainter(lines: _lines),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ColorSelector(
                    supportColors: supportColors,
                    activeIndex: _activeColorIndex,
                    onSelect: _onSelectColor,
                  ),
                ),
                StorkWidthSelector(
                  supportStorkWidths: supportStorkWidths,
                  activeIndex: _activeStorkWidthIndex,
                  color: supportColors[_activeColorIndex],
                  onSelect: _onSelectStorkWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
