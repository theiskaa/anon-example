import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/view/screens/pages/home/home.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';

void main() {
  Anon anon;

  // Navigator observer.
  MockNavigatorObserver mockObserver;

  // Testable widget builder for lomsa for sign up tests.
  TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() async {
    anon = Anon();

    mockObserver = MockNavigatorObserver();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: Home(),
      navigatorObservers: [mockObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (_) => UserserviceBloc()),
      ],
    );
  });

  group("[Home]", () {
    Future<void> testStatelessWidgets(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);
      expect(find.byType(Padding), findsNWidgets(3));
      expect(find.byType(OpacityButton), findsNWidgets(2));
      expect(find.byType(CreateButton), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      // FIXME: expect(find.byKey(Key('warning.image')), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(Column), findsOneWidget);
      // FIXME: expect(find.byType(PostCardWidget), findsOneWidget);
      expect(find.byType(SizedBox), findsNWidgets(2));
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(RefreshIndicator), findsOneWidget);
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testStatelessWidgets],
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
