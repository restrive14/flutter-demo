import 'package:demo/model/AudioOption.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

/// 音效选项面板
class AudioOptionPanel extends StatelessWidget {
  final List<AudioOption> audioOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const AudioOptionPanel({
    super.key,
    required this.audioOptions,
    required this.activeIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: const Text(
                "选择音效",
                style: labelStyle,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    audioOptions.length,
                    (index) => _buildByIndex(index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    return ListTile(
      selected: index == activeIndex,
      onTap: () => onSelect(index),
      title: Text('${audioOptions[index].name}'),
      trailing: IconButton(
        splashRadius: 20,
        onPressed: () => _tempPlay('${audioOptions[index].src}'),
        icon: const Icon(
          Icons.record_voice_over_rounded,
          color: Colors.blue,
        ),
      ),
    );
  }

  void _tempPlay(String src) async {
    AudioPool pool = await FlameAudio.createPool(src, maxPlayers: 1);
    pool.start();
  }
}
