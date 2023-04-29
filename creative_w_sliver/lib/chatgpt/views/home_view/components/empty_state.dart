import 'package:isaac_roberts_consulting/chatgpt/model/empty_state_card_model.dart';
import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/intro_card.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({
    Key? key,
  }) : super(key: key);

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  final List<EmptyStateCardModel> list = [
    exampleCardModel,
    capabilitiesCardModel,
    limitationsCardModel
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return IntroCards(
                  card: list[index],
                );
              }),
        ],
      ),
    );
  }
}
