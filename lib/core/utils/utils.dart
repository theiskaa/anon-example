import 'package:flutter/widgets.dart';

void wrapWith(
  TextEditingController controller, {
  @required String leftSide,
  String rightSide,
}) {
  final text = controller.value.text;
  final selection = controller.selection;
  final middle = selection.textInside(text);
  final newText = selection.textBefore(text) +
      '$leftSide$middle$rightSide' +
      selection.textAfter(text);

  controller.value = controller.value.copyWith(
    text: newText,
    selection: TextSelection.collapsed(
      offset: selection.baseOffset + leftSide.length + middle.length,
    ),
  );
}
