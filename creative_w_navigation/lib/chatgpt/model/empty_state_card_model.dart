import 'package:flutter/material.dart';

class EmptyStateCardModel {
  final String title;
  final IconData icon;
  final List items;

  const EmptyStateCardModel(
      {required this.title, required this.icon, required this.items});
}

EmptyStateCardModel exampleCardModel = const EmptyStateCardModel(
    title: 'Examples',
    icon: Icons.lightbulb_outline,
    items: [
      "Explain quantum computing in simple terms",
      "Got any creative ideas for a 10 year old's birthday?",
      "How do I make an HTTP request in Javascript?"
    ]);

EmptyStateCardModel capabilitiesCardModel = const EmptyStateCardModel(
    title: 'Capabilities',
    icon: Icons.bolt_outlined,
    items: [
      "Remembers what user said earlier in the conversation",
      "Allows user to provide follow-up corrections",
      "Trained to decline inappropriate requests"
    ]);

EmptyStateCardModel limitationsCardModel = const EmptyStateCardModel(
    title: 'Limitations',
    icon: Icons.warning_amber_rounded,
    items: [
      "May occasionally generate incorrect information",
      "May occasionally produce harmful instructions or biased content",
      "Limited knowledge of world and events after 2021"
    ]);
