import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:anon/core/services/auth_service.dart';
import 'package:anon/core/system/anon.dart';

export 'package:flutter_test/flutter_test.dart';
export 'package:mockito/mockito.dart';

/// [MockNavigatorObserver] functions as mocked version of
/// [NavigatorObserver] class. This makes navigation testing
/// much easier and efficient.
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// [MockAuthService] functions as mocked version of [AuthService] class.
class MockAuthService extends Mock implements AuthService {}

class TestStatelessWidget extends AnonStatelessWidget {
  TestStatelessWidget({Key key}) : super(key: key);
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestStatefulWidget extends AnonStatefulWidget {
  TestStatefulWidget({Key key}) : super(key: key);
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestAnonState extends AnonStatefulWidget {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Generic function that verifies whether or not
/// a Widget instance is a subtype of [AnonStatelessWidget].
/// It finds first subtype of [AnonStatelessWidget] and
/// checks if the Widget instance has a property of [Anon] type.
Future<void> testAnonDependency<T extends StatelessWidget>(
    WidgetTester tester) async {
  final T testableWidget = tester.firstWidget(
    find.byWidgetPredicate(
      (widget) => widget is T,
      description: 'first child widget of LomsaStatelessWidget',
      skipOffstage: true,
    ),
  );

  expect(testableWidget, isA<Anon>());
}

class TestableWidgetBuilder {
  final Anon anon;
  Widget widget;
  final List<NavigatorObserver> navigatorObservers;
  List<BlocProvider> blocProviders;
  final bool enablePageTesting;

  TestableWidgetBuilder({
    this.anon,
    this.widget,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.blocProviders,
    this.enablePageTesting = false,
  });

  /// [buildTestableWidget] builds a bare minimum
  /// tree structure of widgets (mostly Stateless)
  /// that are necessary for a functioning Anon application.
  Widget buildTestableWidget({Widget widget}) => MaterialApp(
        home: enablePageTesting
            ? widget ?? this.widget
            : Scaffold(body: widget ?? this.widget),
        navigatorObservers: navigatorObservers,
      );

  /// Akin to [buildTestableWidget] but intended
  /// towards Stateful widgets with BLOC providers.
  Widget buildTestableStateWidget({Widget widget}) => buildTestableWidget(
        widget: MultiBlocProvider(
          providers: blocProviders,
          child: buildTestableWidget(widget: widget ?? this.widget),
        ),
      );
}

typedef TestableWidgetBuildMethod = Widget Function();

typedef TestCase = Future<void> Function(WidgetTester);

typedef TestProcessor = Future<void> Function();

/// [asyncTestWidgets] is a [Function] for testing widgets in predefined and

Future<void> asyncTestWidgets(
  WidgetTester tester, {
  TestableWidgetBuildMethod build,
  TestProcessor preProcess,
  List<TestCase> testCases,
  TestProcessor postProcess,
  bool containsAnimations = false,
}) async =>
    await tester.runAsync(() async {
      if (preProcess != null) await preProcess();
      final widget = build();
      await tester.pumpWidget(widget);

      if (build != null) {
        if (containsAnimations) {
          await tester.pumpAndSettle();
        } else {
          await tester.pump(Duration(seconds: 3));
        }

        if (testCases != null) {
          await Future.forEach(
            testCases,
            (TestCase testCase) async => await testCase(tester),
          );
        }
      }

      if (postProcess != null) await postProcess();
    });

/// [closeBlocStreams] iterates over [blocs] and closes open streams.
Future<void> closeBlocStreams(List<Bloc> blocs) async =>
    await Future.forEach(blocs, (Bloc bloc) async => await bloc.close());
