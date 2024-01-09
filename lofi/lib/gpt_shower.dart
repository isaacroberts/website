import 'package:flutter/material.dart';

import 'chatgpt/views/home_view/inlayed_view.dart';
import 'feature_shower.dart';

class GPTShower extends StatelessWidget with FeatureShower {
  final bool textLeft;
  const GPTShower(this.textLeft, {super.key});

  @override
  String title() => 'ChatGPT';
  @override
  String subtitle() => 'Integrate groundbreaking AI into your app.';
  @override
  String body() =>
      """ChatGPT can serve as a user support line, autocompletion tool, email writer, or even as a salesperson. Explore what's possible with ChatGPT and GPT-4.
          """;
  @override
  String bgImage() => 'images/ai.jpg';

  @override
  bool shouldExpandToDisplay() => true;

  @override
  Widget displayContent(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15), child: const InlayedGPTView());

    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15), child: InlayedGPTView());
  }

  @override
  Widget build(BuildContext context) {
    return doBuild(context, textLeft);
  }
}
