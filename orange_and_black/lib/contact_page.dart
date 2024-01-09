import 'dart:developer';
import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:isaac_roberts_consulting/server.dart';
import 'app_bar.dart';
import 'theme.dart';
import 'common_elements.dart';
import 'text_theme.dart';
import 'dart:math' as math;

Widget fabSwitcher(BuildContext context, bool isOpen, {var onPressed}) {
  return FloatingActionButton(
      key: const Key('fab'),
      // child: AnimatedSwitcher(
      //     duration: const Duration(milliseconds: 350),
      //     transitionBuilder: (child, anim) =>
      //         ScaleTransition(scale: anim, child: child),
      child: isOpen
          ? const Icon(Icons.send_outlined, key: ValueKey('sendicon'))
          : const Icon(
              Icons.email_outlined,
              key: ValueKey('emailicon'),
            ),
      onPressed: () {
        if (isOpen) {
          onPressed();
        } else {
          contactButtonPressed(context, true);
        }
      });
}

class ContactBackdrop extends StatelessWidget {
  final bool fromFab;
  const ContactBackdrop(this.fromFab, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();

    return Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        elevation: 10,
        // child: Align(
        //     alignment: Alignment.bottomRight,
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: ContactPage(fromFab))));
  }
}

class ContactPage extends StatefulWidget {
  final bool fromFab;
  const ContactPage(this.fromFab, {Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

// Global var to save email
String prevText = '';
bool wasSubmitted = false;
bool wasPrevValid = false;

class _ContactPageState extends State<ContactPage> {
  late TextEditingController controller;
  String? emailErrMsg;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController(text: prevText);
    controller.addListener(_revalidateEmail);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        // mainAxisAlignment: M,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            double w = math.min(constraints.maxWidth, 540);
            return Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                    width: w,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          autofocus: true,
                          autocorrect: false,
                          controller: controller,
                          onFieldSubmitted: (s) => sendEmail(),
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              errorText: emailErrMsg,
                              hintText: 'Enter your email'),
                        ))));
          })),
          fabSwitcher(context, true, onPressed: sendEmail),
          const SizedBox(width: 15)
        ]);
  }

  void sendEmail() async {
    String email = controller.value.text;
    if (email.isEmpty) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      return;
    } else if (!EmailValidator.validate(email)) {
      setState(() {
        emailErrMsg = 'Invalid email';
      });
      return;
    } else if (emailErrMsg != null) {
      setState(() {
        emailErrMsg = null;
      });
    }

    String body = widget.fromFab ? '[from fab]' : '[from appbar]';
    sendSignup(email, body).then(responseReceived);
  }

  void responseReceived(String? errmsg) {
    if (errmsg == null) {
      prevText = '';
      wasSubmitted = true;
      setState(() {
        emailErrMsg = '';
      });

      if (mounted) {
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        emailErrMsg = 'Not submitted - $errmsg';
      });
    }
  }

  void _revalidateEmail() {
    prevText = controller.value.text;

    if (emailErrMsg != null) {
      if (EmailValidator.validate(controller.value.text)) {
        setState(() {
          emailErrMsg = null;
        });
      }
    }
  }
}
