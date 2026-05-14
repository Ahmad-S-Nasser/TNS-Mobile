import 'package:flutter/material.dart';
import 'package:tips_n_steps/core/helpers/extension.dart';

class ContentTopicsWrap extends StatelessWidget {
  final List<String> topics;

  const ContentTopicsWrap({
    super.key,
    required this.topics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المواضيع المشمولة',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.SP),
        ),
        12.vS,
        Wrap(
          spacing: 8.W,
          children: topics
              .map((t) => Chip(
                    label: Text(t, style: TextStyle(fontSize: 12.SP)),
                    backgroundColor:
                        const Color(0xFF23A99A).withValues(alpha: 0.12),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
