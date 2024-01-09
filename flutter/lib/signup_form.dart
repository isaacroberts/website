import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:isaac_roberts_consulting/server.dart';

import 'common_elements.dart';
import 'text_theme.dart';
import 'theme.dart';

import 'device.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

//Enter your email box with stock photo - business or laughing or trees or something

//Add something else - maybe body for details, or name field

//Image covers both sides, one side glassy with text field & box

// const String imgAsset = 'images/email_cta.jpg';
const String imgAsset = 'images/swimming_deer.jpg';
// const double signupFormHeight = 400;

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey _backgroundImageKey = GlobalKey(debugLabel: 'signup img');

  final TextEditingController emailField = TextEditingController();
  final TextEditingController msgField = TextEditingController();

  String? emailErrMsg;
  bool submitted = false;

  _SignupFormState() {
    emailField.addListener(_revalidateEmail);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 400, child: Center(child: glassAndText(context)));

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > watchSize) {
        return SizedBox(
            height: 400, width: Device.width, child: imgStack(context));
      } else {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  //email_cta.jpg
                  image: assetProvider(imgAsset),
                  fit: BoxFit.cover)),
          child: Padding(
              padding: const EdgeInsets.all(15), child: watchContent(context)),
        );
      }
    });
    // return FlutterLogo();
    // return SizedBox(height: 400, width: Device.width, child: FlutterLogo());
    return SizedBox(height: 400, width: Device.width, child: imgStack(context));
  }

  Widget imgStack(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: [
      ClipRect(child: parallaxImg(context)),
      glassAndText(context),
    ]);
  }

  Widget parallaxImg(BuildContext context) {
    return LayoutBuilder(
        key: const Key('email_cta_paralax'),
        builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth / constraints.maxHeight;
          double imgAspect = 1.52;
          if (aspectRatio > imgAspect) {
            return Flow(
                key: const Key('email_cta_flow'),
                delegate: ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: _backgroundImageKey,
                  distance: 0,
                ),
                children: [
                  //
                  fadeAssetBg(imgAsset,
                      fit: BoxFit.cover, key: _backgroundImageKey),
                ]);
          } else {
            return SizedBox(
                key: const Key('email_cta_box'),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: fadeAssetBg(imgAsset,
                    fit: BoxFit.cover, key: _backgroundImageKey));
          }
        });
  }

  Widget glassAndText(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
                height: constraints.maxHeight,
                width: math.max(800 - k * 4, constraints.maxWidth / 2),
                child: glassAndTextContent()));
        return
            // child: ConstrainedBox(
            //     constraints: const BoxConstraints(
            //         maxWidth: processWidth + standardContainerMargin * 2),
            Align(
                alignment: Alignment.topCenter,
                child: FractionallySizedBox(
                    widthFactor: .5,
                    heightFactor: 1,
                    child: glassAndTextContent()));
      } else {
        return Center(child: glassAndTextContent());
      }
    });
  }

  Padding glassAndTextContent() {
    return Padding(
        padding: const EdgeInsets.all(standardContainerMargin),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                  // color: Colors.yellow,
                  decoration:
                      BoxDecoration(color: theme.cardColor.withOpacity(0.4)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: textContainerMargin,
                          horizontal: textContainerMargin),
                      child: content()))),
        ));
  }

  Widget content() {
    if (!submitted) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const SizedBox(height: 15),
            Text(
              'Get started',
              style: fonts.displayLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
                'Enter your email and I\'ll get back to you with questions about your project.',
                style: fonts.bodyLarge,
                textAlign: TextAlign.left),
            // Expanded(child: LayoutBuilder(builder: (context, constraints) {
            //   log('avail height: ${constraints.maxHeight}');
            //   return SizedBox.shrink();
            // })),
            const SizedBox(height: 15),
            signupRow()
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Text(
              'Thanks!',
              style: fonts.headlineSmall,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            paraLarge('I\'ll get back to you soon!'),
            // SizedBox(height: 15),
          ]);
    }
  }

  Widget watchContent(BuildContext context) {
    if (!submitted) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Get started',
              style: watchFonts.headlineMedium,
              textAlign: TextAlign.left,
            ),
            Text(
                'Enter your email and I\'ll get back to you with questions about your project.',
                style: watchFonts.headlineMedium,
                textAlign: TextAlign.left),
            signupRow()
          ]);
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thanks!',
              style: watchFonts.headlineMedium,
              textAlign: TextAlign.left,
            ),
            paraLarge('I\'ll get back to you soon!'),
            // SizedBox(height: 15),
          ]);
    }
  }

  Widget signupRow() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TODO: SizedBox so the errormsg expands into it
          textForm(),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () => sendEmail(), child: submitButton())
        ]);
    // }
    // });
  }

  Text submitButton() => const Text('Submit');

  TextFormField textForm() {
    var style =
        Device.width > watchSize ? fonts.titleMedium : watchFonts.bodyMedium;
    return TextFormField(
      controller: emailField,
      onFieldSubmitted: (s) => sendEmail(),
      style: style,
      decoration:
          InputDecoration(errorText: emailErrMsg, hintText: 'Enter your email'),
    );
  }

  void _revalidateEmail() {
    if (emailErrMsg != null) {
      if (EmailValidator.validate(emailField.value.text)) {
        setState(() {
          emailErrMsg = null;
        });
      }
    }
  }

  void sendEmail() async {
    String email = emailField.value.text;
    if (email.isEmpty) {
      setState(() {
        emailErrMsg = 'Please enter an email';
      });
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
    String body = msgField.text;
    if (body.isEmpty) {
      body = '[from signup form]';
    }
    sendSignup(email, body).then(signupReceived);
  }

  void signupReceived(String? errmsg) {
    if (errmsg == null) {
      setState(() {
        emailErrMsg = null;
        submitted = true;
      });
    } else {
      setState(() {
        emailErrMsg = errmsg;
      });
    }
  }
}

Widget signupFormSliver({Key? key}) {
  return SliverToBoxAdapter(key: key, child: const SignupForm());
}

/*

// **********************************************************
// ***  Original version with its own sliver & background ***
// **********************************************************

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final GlobalKey _backgroundImageKey = GlobalKey(debugLabel: 'signup img');

  final TextEditingController emailField = TextEditingController();
  final TextEditingController msgField = TextEditingController();

  String? emailErrMsg;
  bool submitted = false;

  _SignupFormState() {
    emailField.addListener(_revalidateEmail);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > watchSize) {
        return SizedBox(
            height: 400, width: Device.width, child: imgStack(context));
      } else {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  //email_cta.jpg
                  image: assetProvider(imgAsset),
                  fit: BoxFit.cover)),
          child: Padding(
              padding: const EdgeInsets.all(15), child: watchContent(context)),
        );
      }
    });
    // return FlutterLogo();
    // return SizedBox(height: 400, width: Device.width, child: FlutterLogo());
    return SizedBox(height: 400, width: Device.width, child: imgStack(context));
  }

  Widget imgStack(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: [
      ClipRect(child: parallaxImg(context)),
      glassAndText(context),
    ]);
  }

  Widget parallaxImg(BuildContext context) {
    return LayoutBuilder(
        key: const Key('email_cta_paralax'),
        builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth / constraints.maxHeight;
          double imgAspect = 1.52;
          if (aspectRatio > imgAspect) {
            return Flow(
                key: const Key('email_cta_flow'),
                delegate: ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: _backgroundImageKey,
                  distance: 0,
                ),
                children: [
                  //
                  fadeAssetBg(imgAsset,
                      fit: BoxFit.cover, key: _backgroundImageKey),
                ]);
          } else {
            return SizedBox(
                key: const Key('email_cta_box'),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: fadeAssetBg(imgAsset,
                    fit: BoxFit.cover, key: _backgroundImageKey));
          }
        });
  }

  Widget glassAndText(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 800) {
        return Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: processWidth + standardContainerMargin * 2),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                        widthFactor: .5,
                        heightFactor: 1,
                        child: glassAndTextContent()))));
      } else {
        return Center(child: glassAndTextContent());
      }
    });
  }

  Padding glassAndTextContent() {
    return Padding(
        padding: const EdgeInsets.all(standardContainerMargin),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                  // color: Colors.yellow,
                  decoration:
                      BoxDecoration(color: theme.cardColor.withOpacity(0.4)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: textContainerMargin,
                          horizontal: textContainerMargin),
                      child: content()))),
        ));
  }

  Widget content() {
    if (!submitted) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const SizedBox(height: 15),
            Text(
              'Get started',
              style: fonts.displayLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            Text(
                'Enter your email and I\'ll get back to you with questions about your project.',
                style: fonts.bodyLarge,
                textAlign: TextAlign.left),
            // Expanded(child: LayoutBuilder(builder: (context, constraints) {
            //   log('avail height: ${constraints.maxHeight}');
            //   return SizedBox.shrink();
            // })),
            const SizedBox(height: 15),
            signupRow()
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            Text(
              'Thanks!',
              style: fonts.headlineSmall,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 15),
            paraLarge('I\'ll get back to you soon!'),
            // SizedBox(height: 15),
          ]);
    }
  }

  Widget watchContent(BuildContext context) {
    if (!submitted) {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Get started',
              style: watchFonts.headlineMedium,
              textAlign: TextAlign.left,
            ),
            Text(
                'Enter your email and I\'ll get back to you with questions about your project.',
                style: watchFonts.headlineMedium,
                textAlign: TextAlign.left),
            signupRow()
          ]);
    } else {
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thanks!',
              style: watchFonts.headlineMedium,
              textAlign: TextAlign.left,
            ),
            paraLarge('I\'ll get back to you soon!'),
            // SizedBox(height: 15),
          ]);
    }
  }

  Widget signupRow() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //TODO: SizedBox so the errormsg expands into it
          textForm(),
          const SizedBox(height: 15),
          ElevatedButton(onPressed: () => sendEmail(), child: submitButton())
        ]);
    // }
    // });
  }

  Text submitButton() => const Text('Submit');

  TextFormField textForm() {
    var style =
        Device.width > watchSize ? fonts.titleMedium : watchFonts.bodyMedium;
    return TextFormField(
      controller: emailField,
      onFieldSubmitted: (s) => sendEmail(),
      style: style,
      decoration:
          InputDecoration(errorText: emailErrMsg, hintText: 'Enter your email'),
    );
  }

  void _revalidateEmail() {
    if (emailErrMsg != null) {
      if (EmailValidator.validate(emailField.value.text)) {
        setState(() {
          emailErrMsg = null;
        });
      }
    }
  }

  void sendEmail() async {
    String email = emailField.value.text;
    if (email.isEmpty) {
      setState(() {
        emailErrMsg = 'Please enter an email';
      });
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
    String body = msgField.text;
    if (body.isEmpty) {
      body = '[from signup form]';
    }
    sendSignup(email, body).then(signupReceived);
  }

  void signupReceived(String? errmsg) {
    if (errmsg == null) {
      setState(() {
        emailErrMsg = null;
        submitted = true;
      });
    } else {
      setState(() {
        emailErrMsg = errmsg;
      });
    }
  }
}

Widget signupFormSliver({Key? key}) {
  return SliverToBoxAdapter(key: key, child: const SignupForm());
}
*/

class LoneSignupImage extends StatefulWidget {
  const LoneSignupImage({Key? key}) : super(key: key);

  @override
  State<LoneSignupImage> createState() => _LoneSignupImageState();
}

class _LoneSignupImageState extends State<LoneSignupImage> {
  final GlobalKey _backgroundImageKey = GlobalKey(debugLabel: 'signup img');

  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.lightGreenAccent);
    return LayoutBuilder(
        key: const Key('email_cta_paralax'),
        builder: (context, constraints) {
          double aspectRatio = constraints.maxWidth / constraints.maxHeight;
          double imgAspect = 1;
          if (aspectRatio > imgAspect) {
            return Flow(
                key: const Key('email_cta_flow'),
                delegate: ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: _backgroundImageKey,
                  distance: 0,
                ),
                children: [
                  //
                  fadeAssetBg(imgAsset,
                      fit: BoxFit.cover, key: _backgroundImageKey),
                ]);
          } else {
            return SizedBox(
                key: const Key('email_cta_box'),
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: fadeAssetBg(imgAsset,
                    fit: BoxFit.cover, key: _backgroundImageKey));
          }
        });
  }
}
