part of 'userservice_bloc.dart';

enum UserServiceEvents {
  getAllStart,
  getAllSuccess,
  getAllError,

  createPostStart,
  createPostSuccess,
  createPostError,

  putCommentStart,
  putCommentSuccess,
  putCommentError,

  getSavedStart,
  getSavedSuccess,
  getSavedError,

  savePostStart,
  savePostSuccess,
  savePostError,
}

class UserServiceEvent {
  UserServiceEvents type;
  PostModel postModel;
  CommentModel commentModel;

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

  UserServiceEvent.putCommentStart(
    PostModel postModel,
    CommentModel commentModel,
  ) {
    this.type = UserServiceEvents.putCommentStart;
    this.commentModel = commentModel;
    this.postModel = postModel;
  }

  UserServiceEvent.putCommentSuccess() {
    this.type = UserServiceEvents.putCommentSuccess;
  }

  UserServiceEvent.putCommentError() {
    this.type = UserServiceEvents.putCommentError;
  }

  UserServiceEvent.savePostStart(PostModel post) {
    this.type = UserServiceEvents.savePostStart;
    this.postModel = post;
  }

  UserServiceEvent.savePostSuccess() {
    this.type = UserServiceEvents.savePostSuccess;
  }

  UserServiceEvent.savePostError() {
    this.type = UserServiceEvents.savePostError;
  }

  UserServiceEvent.getSavedStart() {
    this.type = UserServiceEvents.getSavedStart;
  }

  UserServiceEvent.getSavedSuccess() {
    this.type = UserServiceEvents.getSavedSuccess;
  }

  UserServiceEvent.getSavedError() {
    this.type = UserServiceEvents.getSavedError;
  }
}
