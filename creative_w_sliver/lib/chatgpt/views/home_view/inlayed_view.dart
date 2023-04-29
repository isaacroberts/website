import 'package:isaac_roberts_consulting/chatgpt/controller/chat_controller.dart';
import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

class InlayedGPTView extends StatefulWidget {
  final ChatController chatController;

  const InlayedGPTView({super.key, required this.chatController});

  @override
  State<InlayedGPTView> createState() => _InlayedGPTViewState();
}

class _InlayedGPTViewState extends State<InlayedGPTView> {
  final ScrollController _controller = ScrollController(keepScrollOffset: true);

  ChatController get chatController => widget.chatController;

  void scrollDown() {
    if (_controller.position.maxScrollExtent > 0) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  ListView.builder(
                      // controller: _controller,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: chatController
                          .chats[chatController.chatIndex].messages.length,
                      itemBuilder: (context, index) {
                        final message = chatController
                            .chats[chatController.chatIndex].messages.reversed
                            .toList();

                        // To scroll down to the bottom of the list after the list is built
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => scrollDown());

                        return ChatCard(
                          messageBlock: message[index],
                        );
                      }),
                  Visibility(
                    visible: chatController.isLoading &&
                        chatController.chatIndex == chatController.promptIndex,
                    child: const OtherCard(type: OtherCardType.loading),
                  ),
                  Visibility(
                    visible:
                        chatController.chats[chatController.chatIndex].error !=
                            null,
                    child: OtherCard(
                      type: OtherCardType.error,
                      response:
                          chatController.chats[chatController.chatIndex].error,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(5), child: customChatInput())
        ],
      );
    });
  }

  Widget customChatInput() {
    TextEditingController controller = TextEditingController();
    return Container(
      height: 40,
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Theme.of(context).shadowColor,
        //     spreadRadius: 0.5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 2), // changes position of shadow
        //   ),
        // ],
        color: Colors.black,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: TextField(
                enabled: !chatController.isLoading,
                onSubmitted: (value) {
                  _handleSendPressed(controller.text);
                },
                controller: controller,
                cursorColor: Colors.white,
                cursorRadius: const Radius.circular(5),
                maxLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  _handleSendPressed(controller.text);
                }
              },
              icon: const Icon(Icons.send_outlined)),
        ],
      ),
    );
  }

  InputOptions inputOptions() {
    return const InputOptions(
        sendButtonVisibilityMode: SendButtonVisibilityMode.always);
  }

  DefaultChatTheme defaultChatTheme() {
    return DefaultChatTheme(
      userAvatarImageBackgroundColor: Colors.white,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //  inputBackgroundColor: Colors.red,
      sendButtonIcon: Image.asset('assets/send.png'),
    );
  }

  void _handleSendPressed(String message) {
    chatController.handleSendPressed(message);
  }
}
