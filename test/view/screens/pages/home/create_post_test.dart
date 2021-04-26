import 'package:anon/view/screens/pages/home/create_post.dart';
import 'package:anon/view/widgets/components/markdown_editbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  Anon anon;

  // Navigator observer.
  MockNavigatorObserver mockObserver;

  // Testable widget builder for test CreatePost page.
  TestableWidgetBuilder testableWidgetBuilder;

  // Testable widget builder for test CreatePost page.
  TestableWidgetBuilder testableWidgetBuilderForPreview;

  setUpAll(() async {
    anon = Anon();

    mockObserver = MockNavigatorObserver();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: CreatePost(),
      navigatorObservers: [mockObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (_) => UserserviceBloc()),
      ],
    );

    testableWidgetBuilderForPreview = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: CreatePost(segmentedValue: 1),
      navigatorObservers: [mockObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (_) => UserserviceBloc()),
      ],
    );
  });

  group("[CreatePost]", () {
    Future<void> testStatelessWidgets(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(Padding), findsNWidgets(7));
      expect(find.byType(CreateButton), findsOneWidget);
      expect(find.byType(MarkdownEditBar), findsOneWidget);
      expect(find.byType(OpacityButton), findsNWidgets(10));
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(5));
      expect(find.byType(Center), findsNWidgets(13));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Form), findsOneWidget);
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
      'Validator of title field should work properly',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        postProcess: () async {
          final titleField = find.byKey(Key('title.field'));
          final createButton = find.byKey(Key('create.button'));

          // Blank empty field value to test validator.
          await tester.enterText(titleField, "");

          await tester.tap(createButton);
          await tester.pumpAndSettle();

          expect(find.text("Title can't be empty!"), findsOneWidget);
        },
      ),
    );
    testWidgets(
      'Leading of Default appbar should work properly',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        postProcess: () async {
          final appBarLeading = find.byKey(Key("go.back.button"));

          await tester.tap(appBarLeading);
          await tester.pumpAndSettle();

          // Verify that navigation was popped.
          verify(mockObserver.didPop(any, any));
        },
      ),
    );

    Future<void> testCreatPageWhithPreviewWidget(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(Padding), findsNWidgets(7));
      expect(find.byType(CreateButton), findsOneWidget);
      expect(find.byType(OpacityButton), findsNWidgets(2));
      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(Center), findsNWidgets(3));
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(SizedBox), findsNWidgets(6));
    }

    testWidgets(
      'should contain initial states and widgets (Preview)',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilderForPreview.buildTestableStateWidget,
        testCases: [testCreatPageWhithPreviewWidget],
      ),
    );
  });
}
