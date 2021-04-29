import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/screens/pages/home/home.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';

void main() {
  Anon anon;
  Widget homePage;

  MockNavigatorObserver mockObserver;

  // Testable widget builder for test Home page.
  TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() async {
    anon = Anon();

    mockObserver = MockNavigatorObserver();

    homePage = Home();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: homePage,
      navigatorObservers: [mockObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (_) => UserserviceBloc()),
      ],
    );
  });

  group("[Home]", () {
    Future<void> testInitialWidgetsAndStatesOfHome(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);
      expect(find.byType(Padding), findsNWidgets(3));
      expect(find.byType(OpacityButton), findsNWidgets(2));
      expect(find.byType(CreateButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(3));
      expect(find.byType(SizedBox), findsNWidgets(2));
      // FIXME: expect(find.byType(RefreshIndicator), findsOneWidget);
      // FIXME: expect(find.byType(LazyLoadListView), findsOneWidget);
      // FIXME: expect(find.byType(PostCardWidget), findsOneWidget);
      // FIXME: expect(find.byKey(Key('warning.image')), findsOneWidget);
      // FIXME: expect(find.byType(Column), findsOneWidget);
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testInitialWidgetsAndStatesOfHome],
      ),
    );

    testWidgets(
      'Create button should work properly',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        postProcess: () async {
          final createButton = find.byKey(Key('create.button'));

          await tester.tap(createButton);
          await tester.pumpAndSettle();

          // Verify that navigation was pushed.
          verify(mockObserver.didPush(any, any));
        },
      ),
    );
  });
}
