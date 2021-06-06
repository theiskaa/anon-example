import 'package:anon/core/utils/utils.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';

import '../anon_widgets.dart';

class MarkdownEditBar extends AnonStatelessWidget {
  final TextEditingController controller;
  final ScrollController? scrollController;

  MarkdownEditBar({
    Key? key,
    required this.controller,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Center(
            child: Scrollbar(
              controller: scrollController,
              isAlwaysShown: true,
              child: markdownEditItems(),
            ),
          ),
        ),
      ),
    );
  }

  markdownEditItems() => ListView.separated(
        shrinkWrap: true,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: _buttonList().length,
        itemBuilder: (context, index) {
          return _buttonList()[index];
        },
        separatorBuilder: (context, index) => SizedBox(width: 20),
      );

  List<OpacityButton> _buttonList() {
    var list = [
      OpacityButton(
        key: Key('mk.header'),
        child: Icon(Icons.format_size_rounded, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '# ', rightSide: ''),
      ),
      OpacityButton(
        key: Key('mk.bold'),
        child: Icon(Icons.format_bold, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '**', rightSide: '**'),
      ),
      OpacityButton(
        key: Key('mk.list'),
        child: Icon(Icons.list, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '- ', rightSide: ''),
      ),
      OpacityButton(
        key: Key('mk.italic'),
        child: Icon(Icons.format_italic, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '*', rightSide: '*'),
      ),
      OpacityButton(
        key: Key('mk.code'),
        child: Icon(Icons.code, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '```', rightSide: '```'),
      ),
      OpacityButton(
        key: Key('mk.strikethrough'),
        child: Icon(Icons.strikethrough_s_rounded, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '~~', rightSide: '~~'),
      ),
      OpacityButton(
        key: Key('mk.url'),
        child: Icon(Icons.link_sharp, color: Colors.white),
        onTap: () => wrapWith(controller, leftSide: '[', rightSide: ']()'),
      ),
      OpacityButton(
        key: Key('mk.imgUrl'),
        child: Icon(Icons.image, color: Colors.white),
        onTap: () =>
            wrapWith(controller, leftSide: '![](https://', rightSide: ')'),
      ),
    ];

    return list;
  }
}
