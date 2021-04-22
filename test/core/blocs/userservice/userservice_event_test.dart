import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserServiceEvent userServiceEvent;
  PostModel postModel;

  group('[UserServiceEvent]', () {
    test('createPostStart', () {
      userServiceEvent = UserServiceEvent.createPostStart(postModel);

      expect(userServiceEvent.type, UserServiceEvents.createPostStart);
    });

    test('createPostSuccess', () {
      userServiceEvent = UserServiceEvent.createPostSuccess();

      expect(userServiceEvent.type, UserServiceEvents.createPostSuccess);
    });

    test('createPostError', () {
      userServiceEvent = UserServiceEvent.createPostError();

      expect(userServiceEvent.type, UserServiceEvents.createPostError);
    });

    test('getAllStart', () {
      userServiceEvent = UserServiceEvent.getAllStart();

      expect(userServiceEvent.type, UserServiceEvents.getAllStart);
    });

    test('getAllSuccess', () {
      userServiceEvent = UserServiceEvent.getAllSuccess();

      expect(userServiceEvent.type, UserServiceEvents.getAllSuccess);
    });

    test('getAllError', () {
      userServiceEvent = UserServiceEvent.getAllError();

      expect(userServiceEvent.type, UserServiceEvents.getAllError);
    });
  });
}
