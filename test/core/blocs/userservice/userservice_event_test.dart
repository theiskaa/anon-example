import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  UserServiceEvent userServiceEvent;
  PostModel postModel;
  CommentModel commentModel;

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

    test('putCommentStart', () {
      userServiceEvent =
          UserServiceEvent.putCommentStart(postModel, commentModel);

      expect(userServiceEvent.type, UserServiceEvents.putCommentStart);
    });

    test('putCommentSuccess', () {
      userServiceEvent = UserServiceEvent.putCommentSuccess();

      expect(userServiceEvent.type, UserServiceEvents.putCommentSuccess);
    });

    test('putCommentError', () {
      userServiceEvent = UserServiceEvent.putCommentError();

      expect(userServiceEvent.type, UserServiceEvents.putCommentError);
    });

    test('getSavedStart', () {
      userServiceEvent = UserServiceEvent.getSavedStart();

      expect(userServiceEvent.type, UserServiceEvents.getSavedStart);
    });

    test('getSavedSuccess', () {
      userServiceEvent = UserServiceEvent.getSavedSuccess();

      expect(userServiceEvent.type, UserServiceEvents.getSavedSuccess);
    });

    test('getSavedError', () {
      userServiceEvent = UserServiceEvent.getSavedError();

      expect(userServiceEvent.type, UserServiceEvents.getSavedError);
    });

    test('savePostStart', () {
      userServiceEvent = UserServiceEvent.savePostStart(postModel);

      expect(userServiceEvent.type, UserServiceEvents.savePostStart);
    });

    test('savePostSuccess', () {
      userServiceEvent = UserServiceEvent.savePostSuccess();

      expect(userServiceEvent.type, UserServiceEvents.savePostSuccess);
    });

    test('savePostError', () {
      userServiceEvent = UserServiceEvent.savePostError();

      expect(userServiceEvent.type, UserServiceEvents.savePostError);
    });
  });
}
