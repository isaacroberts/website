import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chatgpt/controller/chat_controller.dart';
import 'chatgpt/views/home_view/inlayed_view.dart';
import 'feature_shower.dart';

class GPTShower extends StatefulWidget {
  final bool textLeft;

  const GPTShower(this.textLeft, {Key? key}) : super(key: key);

  @override
  State<GPTShower> createState() => _GPTShowerState();
}

class _GPTShowerState extends State<GPTShower> with FeatureShower {
  ChatController chatController = Get.put(ChatController());

  _GPTShowerState();

  @override
  String title() => 'ChatGPT';
  @override
  String subtitle() => 'Integrate groundbreaking AI into your app.';
  @override
  String body() =>
      """ChatGPT can serve as a user support line, autocompletion tool, email writer, or even as a salesperson. Explore what's possible with ChatGPT and GPT-4.
          """;
  @override
  String bgImage() => 'images/deepmind3.jpg';

  @override
  bool shouldExpandToDisplay() => true;

  @override
  void onVisible() {
    if (!kDebugMode) {
      chatController.handleSendPressed(
          'Please explain why Isaac Roberts consulting is the best for freelance mobile & web.');
    }
  }

  @override
  Widget displayContent(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: InlayedGPTView(chatController: chatController));

    // return const Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 15), child: InlayedGPTView());
  }

  @override
  Widget build(BuildContext context) {
    return doBuild(context, widget.textLeft);
  }
}
