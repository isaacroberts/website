import 'package:isaac_roberts_consulting/chatgpt/model/message_model.dart';
import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/blinking_cursor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:isaac_roberts_consulting/common_elements.dart';

import '../../../../theme.dart';

enum ChatCardType { human, gpt }

class ChatCard extends StatelessWidget {
  // final ChatCardType user;
  final MessageModel messageBlock;
  const ChatCard({
    // required this.user,
    required this.messageBlock,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 110,
        ),
        decoration: BoxDecoration(
          border: messageBlock.author!.id != 'chatGPT'
              ? const Border(
                  bottom: BorderSide(color: Colors.black87, width: 0.6))
              : null,
          color: Theme.of(context).cardColor,

          // color: messageBlock.author!.id != 'chatGPT'
          //     ? Theme.of(context).primaryColor
          //     : Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Grayscale.shade700,
                  borderRadius: BorderRadius.circular(4),
                  image: messageBlock.author!.id == 'chatGPT'
                      ? DecorationImage(
                          image: assetProvider("gpt/chatgpt_logo.png"),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: assetProvider("gpt/user_icon.png"),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    messageBlock.message!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum OtherCardType { loading, error }

class OtherCard extends StatelessWidget {
  final OtherCardType type;
  final Response? response;
  const OtherCard({super.key, required this.type, this.response});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 110,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: assetProvider("gpt/chatgpt_logo.png"),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              type == OtherCardType.loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: BlinkingCursor(),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(response!.body,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.red,
                                    )),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}