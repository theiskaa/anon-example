import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';
import 'package:anon/view/widgets/utils/ext.dart';

class ChooseColorCard extends AnonStatefulWidget {
  final List<String> postColors;
  final Function(String) onSelected;
  final Function onUnselected;

  ChooseColorCard({
    Key key,
    @required this.postColors,
    @required this.onSelected,
    @required this.onUnselected,
  }) : super(key: key);

  @override
  _ChooseColorCardState createState() => _ChooseColorCardState();
}

class _ChooseColorCardState extends AnonState<ChooseColorCard> {
  List<Color> colors = [];
  String choosedColor;

  @override
  void initState() {
    super.initState();
    colors = widget.postColors.map<Color>((i) => i.toColor()).toList();
  }

  void chooseColor(String color) {
    setState(() {
      choosedColor = color;
      colors = [color.toColor(), color.toColor()];
    });
    widget.onSelected(color);
  }

  void removeChoosedColor() {
    setState(() {
      choosedColor = null;
      colors = widget.postColors.map<Color>((i) => i.toColor()).toList();
    });
    widget.onUnselected();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(10),
      ),
      child: colors.length == 2 ? choosedColorArea() : choosingArea(),
    );
  }

  Widget choosedColorArea() {
    return OpacityAnimator(
      duration: const Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            choosedColor.colorToTitle(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          OpacityButton(
            onTap: removeChoosedColor,
            child: const Icon(
              CupertinoIcons.clear_circled_solid,
              color: Colors.black,
              size: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget choosingArea() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      child: OpacityAnimator(
        duration: const Duration(milliseconds: 500),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: widget.postColors
              .map(
                (stringColor) => OpacityButton(
                  onTap: () => chooseColor(stringColor),
                  child: Text(
                    stringColor.colorToTitle(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
