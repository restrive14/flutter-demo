import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List<Color> supportColors;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const ColorSelector({
    super.key,
    required this.supportColors,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Wrap(
        spacing: 3,
        runSpacing: 3,
        children: List.generate(
          supportColors.length,
          _buildByIndex,
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool select = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: supportColors[index],
          border: select ? Border.all(color: Colors.blue, width: 3) : null,
        ),
      ),
    );
  }
}
