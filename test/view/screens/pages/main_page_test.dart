import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/screens/pages/home/home.dart';
import 'package:anon/view/screens/pages/main_page.dart';

void main() {
  Anon anon;

  late TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() {
    anon = Anon();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: MainPage(),
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (_) => UserserviceBloc()),
      ],
    );
  });

  group("[Main Page]", () {
    Future<void> testStatelessWidgets(WidgetTester tester) async {
      expect(find.byType(Home), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      // expect(find.byType(BottomNavigationBarItem), findsNWidgets(2));
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(tester,
          build: testableWidgetBuilder.buildTestableStateWidget,
          testCases: [testStatelessWidgets], postProcess: () async {
        final MainPageState mainPageState = tester.state(find.byType(MainPage));

        expect(mainPageState.selectedPage, 0);
        await tester.tap(find.byType(BottomNavigationBar));
      }),
    );
  });
}
