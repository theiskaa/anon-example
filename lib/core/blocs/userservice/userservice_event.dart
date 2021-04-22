part of 'userservice_bloc.dart';

enum UserServiceEvents {
  // Post events.
  createPostStart,
  createPostSuccess,
  createPostError,

  // Get events.
  getAllStart,
  getAllSuccess,
  getAllError,
}

class UserServiceEvent {
  UserServiceEvents type;
  PostModel postModel;

  UserServiceEvent.createPostStart(PostModel postModel) {
    this.type = UserServiceEvents.createPostStart;
    this.postModel = postModel;
  }

  UserServiceEvent.createPostSuccess() {
    this.type = UserServiceEvents.createPostSuccess;
  }

  UserServiceEvent.createPostError() {
    this.type = UserServiceEvents.createPostError;
  }

  UserServiceEvent.getAllStart() {
    this.type = UserServiceEvents.getAllStart;
  }

  UserServiceEvent.getAllSuccess() {
    this.type = UserServiceEvents.getAllSuccess;
  }

  UserServiceEvent.getAllError() {
    this.type = UserServiceEvents.getAllError;
  }
}
