import 'package:anon/core/system/anon.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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

class TestLomsaState extends AnonStatefulWidget {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  AnonStatelessWidget testStatelessAnon;
  AnonStatefulWidget testStatefullAnon;
  AnonStatefulWidget testAnon;

  Anon anonTest;

  setUpAll(() {
    testStatelessAnon = TestStatelessWidget();
    testStatefullAnon = TestStatefulWidget();
    testAnon = TestLomsaState();

    anonTest = Anon();
  });

  group("[Anon Widgets]", () {
    test('Check if anon exists', () async {
      expect(anonTest, testStatelessAnon.anon);
      expect(anonTest, testStatefullAnon.anon);
      expect(anonTest, testAnon.anon);
    });
  });
}
