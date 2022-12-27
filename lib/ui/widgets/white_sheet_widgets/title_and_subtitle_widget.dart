import 'package:flutter/material.dart';
import 'package:pokemon_flutter/utils/constants.dart' as constants;

class TitleAndSubtitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleAndSubtitleWidget({Key? key, required this.title, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: constants.smallPadding),
        Text(subtitle.toString()),
        const SizedBox(height: constants.mediumPadding),
        const Divider(height: 5),
        const SizedBox(height: constants.smallPadding),
      ],
    );
  }
}
