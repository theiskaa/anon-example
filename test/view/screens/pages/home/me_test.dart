import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/me.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;
  List<PostModel> posts;
  UserserviceBloc _userServiceBloc;

  TestableWidgetBuilder testableWidgetBuilder;

  MockNavigatorObserver mockObserver;

  setUpAll(() {
    anon = Anon();
    posts = [
      PostModel(
        userID: 'test id',
        title: "Title of Post",
        content: 'Des of post',
        comments: [],
        color: "#A9CCE3",
      )
    ];

    mockObserver = MockNavigatorObserver();

    _userServiceBloc = UserserviceBloc();

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      navigatorObservers: [mockObserver],
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (context) => _userServiceBloc),
      ],
      widget: Me(),
    );
  });

  group("[Me]", () {
    Future<void> testEmptyListWidget(WidgetTester tester) async {
      expect(find.byType(Me), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);
      expect(find.byType(Center), findsNWidgets(3));
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Icon), findsNWidgets(2));
    }

    testWidgets(
      'should contain widgets | [emptyList]',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testEmptyListWidget],
        postProcess: () async {
          _userServiceBloc.emit(UserServiceState(
              event: UserServiceEvents.getSavedSuccess,
              loading: false,
              savedPosts: posts));
        },
      ),
    );

    Future<void> testListWidget(WidgetTester tester) async {
      expect(find.byType(Me), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBarWithLogo), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(3));
      expect(find.byType(Row), findsNWidgets(3));
      expect(find.byType(SizedBox), findsNWidgets(9));
      expect(find.byType(Container), findsNWidgets(5));
      expect(find.byType(PostCardWidget), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));
    }

    testWidgets(
      'should contain initial widgets | [buildBody]',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testListWidget],
      ),
    );
  });
}
