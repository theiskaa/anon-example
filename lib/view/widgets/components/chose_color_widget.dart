import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';
import 'package:anon/view/widgets/utils/ext.dart';

class ChooseColorCard extends AnonStatefulWidget {
  final List<String> postColors;

  ChooseColorCard({Key key, @required this.postColors}) : super(key: key);

  @override
  _ChooseColorCardState createState() => _ChooseColorCardState();
}

class _ChooseColorCardState extends AnonState<ChooseColorCard>
    with SingleTickerProviderStateMixin {
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
  }

  void removeChoosedColor() {
    setState(() {
      choosedColor = null;
      colors = widget.postColors.map<Color>((i) => i.toColor()).toList();
    });
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
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
              size: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget choosingArea() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: widget.postColors
            .map((stringColor) => OpacityButton(
                  onTap: () => chooseColor(stringColor),
                  child: _ChooseColor(
                    colorAsString: stringColor,
                    isChoosed: false,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _ChooseColor extends StatelessWidget {
  final bool isChoosed;
  final String colorAsString;

  const _ChooseColor({
    Key key,
    this.isChoosed,
    this.colorAsString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        colorAsString.colorToTitle(),
        style: TextStyle(
          color: Colors.black.withOpacity(.8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
