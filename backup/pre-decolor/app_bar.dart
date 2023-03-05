import 'package:flutter/material.dart';
import 'package:website/theme.dart';

import 'device.dart';

/*
class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    super.key,
    required this.child,
  });
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}

class _SABTState extends State<SABT> {
  ScrollPosition? _position;
  bool _visible = false;
  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context)?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: widget.child,
    );
  }
}
*/
List<Widget> buildActions(BuildContext context) {
  List<Widget> list = [];

  list.add(ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.call_outlined),
      label: const Text('Contact')));

  return list;
}

class AnimatingHomeIcon extends StatefulWidget {
  const AnimatingHomeIcon({Key? key}) : super(key: key);

  @override
  State<AnimatingHomeIcon> createState() => _AnimatingHomeIconState();
}

class _AnimatingHomeIconState extends State<AnimatingHomeIcon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    // Scaffold.of(context).openDrawer();
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close, progress: _animationController),
        onPressed: () => _handleOnPressed(),
      );
    });
  }
}

SliverAppBar buildAppBar(BuildContext context) {
  return SliverAppBar(
      elevation: 3,
      stretch: !Device.isLandscapeMobile,
      pinned: !Device.isLandscapeMobile,
      floating: true,
      toolbarHeight: Device.select(def: 50, phoneLand: 40, phonePort: 30),
      // expandedHeight: Device.select(def: 100, landscape: 40),
      // backgroundColor: theme.scaffoldBackgroundColor,
      // flexibleSpace: const FlexibleSpaceBar(
      //   // collapseMode: CollapseMode.pin,
      //   centerTitle: true,
      //   stretchModes: [
      //     // StretchMode.blurBackground,
      //     // StretchMode.fadeTitle,
      //   ],
      //   // background: Device.isPortrait || Device.isDesktop
      //   //     ? Image.asset('assets/images/starry_small.png', fit: BoxFit.cover)
      //   //     : null,
      //   title: Text(
      //     'Isaac Roberts',
      //     textAlign: TextAlign.center,
      //     // style: fonts.headline6?.copyWith(color: colorScheme.onBackground),
      //   ),
      // ),
      title: const Text(
        'Isaac Roberts',
        textAlign: TextAlign.center,
        // style: fonts.headline6?.copyWith(color: colorScheme.onBackground),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        );
      }),
      actions: buildActions(context));
}
