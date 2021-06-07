import 'package:anon/view/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget loading;
  late Widget mainWidget;

  setUpAll(() {
    loading = Loading();

    mainWidget = MaterialApp(
      title: "Loading ",
      home: Scaffold(
        body: Center(child: loading),
      ),
    );
  });

  group("[Loading]", () {
    testWidgets('Loading Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(Loading), findsOneWidget);

      // Loading tests.
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    });
  });
}
