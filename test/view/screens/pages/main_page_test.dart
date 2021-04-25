import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/screens/pages/home/home.dart';
import 'package:anon/view/screens/pages/main_page.dart';

void main() {
  Anon anon;

  TestableWidgetBuilder testableWidgetBuilder;

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
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testStatelessWidgets],
      ),
    );
  });
}
