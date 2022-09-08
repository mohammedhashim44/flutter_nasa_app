import 'package:flutter/material.dart';

class ExtendedTextWidget extends StatefulWidget {
  final String label;
  final String text;
  final Color color;
  final Color backgroundColor;
  final bool initialVisibleState;

  const ExtendedTextWidget(
    this.label,
    this.text, {
    Key? key,
    this.color = Colors.white,
    this.backgroundColor = Colors.blueGrey,
    this.initialVisibleState = false,
  }) : super(key: key);

  @override
  _ExtendedTextWidgetState createState() => _ExtendedTextWidgetState();
}

class _ExtendedTextWidgetState extends State<ExtendedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Duration animatedIconsDuration = const Duration(seconds: 1);
  Duration textExpansion = const Duration(seconds: 1);

  late bool visible;

  @override
  void initState() {
    super.initState();
    visible = widget.initialVisibleState;
    _animationController = AnimationController(
      vsync: this,
      duration: animatedIconsDuration,
    );
    if (visible) {
      _animationController.forward();
    }
  }

  void toggle() {
    setState(() {
      visible = !visible;
      visible ? _animationController.forward() : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: widget.backgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: GestureDetector(
            onTap: toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label,
                ),
                const SizedBox(width: 10),
                AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ExpandedSection(
          duration: textExpansion,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              widget.text,
            ),
          ),
          expand: visible,
        ),
      ],
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Duration duration;

  final Widget child;
  final bool expand;

  const ExpandedSection(
      {Key? key,
      this.expand = false,
      required this.child,
      this.duration = const Duration(seconds: 1)})
      : super(key: key);

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  late Duration duration;

  @override
  void initState() {
    super.initState();
    duration = widget.duration;
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: duration);
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
