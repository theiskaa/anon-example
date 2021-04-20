part of 'userservice_bloc.dart';

enum UserServiceEvents {
  createPostStart,
  createPostSuccess,
  createPostError,
}

class UserServiceEvent {
  UserServiceEvents type;
  PostModel postModel;

  UserServiceEvent.createPostStart(PostModel postModel) {
    this.type = UserServiceEvents.createPostStart;
    this.postModel = postModel;
  }

  UserServiceEvent.createPostSuccess(String name) {
    this.type = UserServiceEvents.createPostSuccess;
  }

  UserServiceEvent.createPostError() {
    this.type = UserServiceEvents.createPostError;
  }
}
