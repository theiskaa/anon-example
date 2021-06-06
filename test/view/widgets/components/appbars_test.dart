import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Anon anon;
  Widget searchBar;
  Widget appBarWithLogo;
  Widget defaultAppBar;

  TestableWidgetBuilder testableWidgetBuilderForSearchBar;
  Widget mainWidgetForAppBarWithLogo;
  Widget mainWidgetForDefaultAppBar;

  MockNavigatorObserver navigatorObserver;
  BoxController boxController;

  const searchablePosts = <PostModel>[
    PostModel(
      userID: 'fasgfasgasgasgasg',
      postID: 'ighuqioialnskaisogq',
      title: 'Test title',
      comments: [],
      content: 'something interesting',
      color: '#F5EEF8',
    ),
  ];

  setUpAll(() {
    anon = Anon();
    boxController = BoxController();

    searchBar = SearchBar(posts: searchablePosts, boxController: boxController);
    appBarWithLogo = AppBarWithLogo();
    defaultAppBar = DefaultAppBar(
      onLeadingTap: () {},
    );

    navigatorObserver = MockNavigatorObserver();

    testableWidgetBuilderForSearchBar = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      widget: Scaffold(appBar: searchBar),
      navigatorObservers: [navigatorObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (context) => UserserviceBloc()),
      ],
    );

    mainWidgetForAppBarWithLogo = MaterialApp(
      title: "AppBar With Logo",
      home: Scaffold(appBar: appBarWithLogo),
    );

    mainWidgetForDefaultAppBar = MaterialApp(
      title: "Default AppBar",
      home: Scaffold(appBar: defaultAppBar),
    );
  });

  group("[SearchBar]", () {
    Future<void> widgetAndFieldTests(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(OpacityAnimator), findsNWidgets(2));
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(2));
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(FieldSuggestion), findsNothing);

      expect(find.byKey(Key('anon.logo')), findsOneWidget);
    }

    testWidgets(
      'test initial widget/states & enter text and expect widget',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilderForSearchBar.buildTestableStateWidget,
        testCases: [widgetAndFieldTests],
        postProcess: () async {
          final SearchBarState searchBarState =
              tester.state(find.byType(SearchBar));

          final searchButton = find.byKey(Key('enable.searching.button'));
          final searchField = find.byKey(Key("search.field"));
          final resultPost = find.byKey(Key('suggested.item'));

          expect(searchBarState.isSearchingEnabled, false);

          await tester.tap(searchButton);
          await tester.pumpAndSettle();

          expect(searchBarState.isSearchingEnabled, true);
          expect(searchField, findsOneWidget);

          await tester.enterText(searchField, 'Test');
          await tester.pumpAndSettle();

          expect(resultPost, findsOneWidget);

          await tester.tap(resultPost);
          await tester.pumpAndSettle();

          // Verify that navigation was pushed.
          verify(navigatorObserver.didPush(any, any));
        },
      ),
    );
  });

  group("[AppBarWithLogo]", () {
    testWidgets('AppBar With Logo Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidgetForAppBarWithLogo);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);

      // AppBarWithLogo tests.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(Key('anon.logo')), findsOneWidget);
    });
  });

  group("[DefaultAppBar]", () {
    testWidgets('defaultAppBar Test', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidgetForDefaultAppBar);

      // MainWidget tests.
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);

      // DefaultAppBar tests.
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byType(OpacityButton), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_outlined), findsOneWidget);

      // Gesture tests.
      await tester.tap(find.byKey(Key("go.back.button")));
    });
  });
}
