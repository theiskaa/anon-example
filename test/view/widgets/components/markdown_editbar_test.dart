import 'package:anon/view/widgets/components/markdown_editbar.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget markdownEditbar;
  late Widget mainWidget;

  TextEditingController textEditingController;
  ScrollController scrollController;

  setUpAll(() {
    textEditingController = TextEditingController();
    scrollController = ScrollController();

    markdownEditbar = MarkdownEditBar(
      controller: textEditingController,
      scrollController: scrollController,
    );

    mainWidget = MaterialApp(
      title: "Markdown Editbar",
      home: Scaffold(bottomNavigationBar: markdownEditbar),
    );
  });

  group("[MarkdownEditBar]", () {
    testWidgets('Markdown EditBar Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(MarkdownEditBar), findsOneWidget);

      // MarkdownEditBar tests.
      expect(find.byType(OpacityButton), findsNWidgets(8));
      expect(find.byType(Transform), findsNWidgets(3));
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(SizedBox), findsNWidgets(16));
      expect(find.byType(Center), findsNWidgets(9));
      expect(find.byType(Scrollbar), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);

      // TODO: Gesture tests
      // await tester.tap(find.byKey(Key('mk.header')));
      // await tester.tap(find.byKey(Key('mk.bold')));
      // await tester.tap(find.byKey(Key('mk.list')));
      // await tester.tap(find.byKey(Key('mk.italic')));
      // await tester.tap(find.byKey(Key('mk.code')));
      // await tester.tap(find.byKey(Key('mk.strikethrough')));
      // await tester.tap(find.byKey(Key('mk.url')));
      // await tester.tap(find.byKey(Key('mk.imgUrl')));
    });
  });
}
