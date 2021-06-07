import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_post.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:anon/core/system/anon.dart';
import 'package:anon/core/utils/test_helpers.dart';

void main() {
  Anon anon;
  PostModel postModel;

  late TestableWidgetBuilder testableWidgetBuilder;

  setUpAll(() {
    anon = Anon();

    postModel = PostModel(
      userID: 'test id',
      title: "Title of Post",
      content: 'Des of post',
      comments: [CommentModel(title: "test title").toJson()],
    );

    testableWidgetBuilder = TestableWidgetBuilder(
      enablePageTesting: true,
      anon: anon,
      blocProviders: [
        BlocProvider<UserserviceBloc>(create: (context) => UserserviceBloc()),
      ],
      widget: ViewPost(postModel: postModel),
    );
  });

  group("[ViewPost]", () {
    Future<void> testViewPostPage(WidgetTester tester) async {
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DefaultAppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(Text), findsNWidgets(2));
    }

    testWidgets(
      'should contain initial states and widgets',
      (WidgetTester tester) async => await asyncTestWidgets(
        tester,
        build: testableWidgetBuilder.buildTestableStateWidget,
        testCases: [testViewPostPage],
        postProcess: () async {
          var bottomBar = find.byKey(Key("view.comments.bar"));

          await tester.tap(bottomBar);
          await tester.pumpAndSettle();
        },
      ),
    );
  });
}
