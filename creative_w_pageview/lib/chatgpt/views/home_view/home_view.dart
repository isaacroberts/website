import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/app_drawer.dart';
import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/appbar.dart';
import 'package:isaac_roberts_consulting/chatgpt/views/home_view/components/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: appBar(), drawer: appDrawer(), body: const HomeViewBody()),
    );
  }
}

// class InlayedGPTView extends StatelessWidget {
//   const InlayedGPTView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
