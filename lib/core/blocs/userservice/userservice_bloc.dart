import 'dart:async';

import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/services/user_service.dart';
import 'package:anon/core/system/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'userservice_event.dart';
part 'userservice_state.dart';

class UserserviceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  final _userService = UserService();

  UserserviceBloc() : super(UserServiceState.defaultState());

  @override
  Stream<UserServiceState> mapEventToState(
    UserServiceEvent event,
  ) async* {
    switch (event.type) {
      case UserServiceEvents.getAllStart:
        yield* mapToGetAllStart(event);
        break;
      case UserServiceEvents.createPostStart:
        yield* mapToCreatePostStart(event);
        break;

      case UserServiceEvents.putCommentStart:
        yield* mapToPutCommentStart(event);
        break;
      default:
    }
  }

  Stream<UserServiceState> mapToGetAllStart(dynamic event) async* {
    UserServiceState serviceState;

    yield state.copyWith(
      event: event.type,
      loading: true,
    );

    try {
      state.postModelList.clear();

      final postsFromFirestore = await _userService.getPosts();

      await _userService.cachePosts(
        postsFromFirestore,
        clearPostsFirst: true,
      );

      List<PostModel> postsFromLocalDatabase =
          await _userService.getCachedPosts();

      serviceState = state.copyWith(
        event: UserServiceEvents.getAllSuccess,
        loading: false,
        postModelList: postsFromLocalDatabase ?? postsFromFirestore,
      );
    } catch (e) {
      Log.e(e.toString());
      serviceState = state.copyWith(
        event: UserServiceEvents.getAllError,
        loading: false,
      );
    }
    yield serviceState;
  }

  Stream<UserServiceState> mapToCreatePostStart(dynamic event) async* {
    UserServiceState serviceState;

    yield state.copyWith(
      event: event.type,
      loading: true,
    );

    try {
      final res = await _userService.createPost(postModel: event.postModel);

      if (res) {
        List<PostModel> posts = List<PostModel>.from(state.postModelList);

        posts.insert(
          0,
          state.postModel.copyWith(
            userID: event.postModel.userID,
            postID: event.postModel.postID,
            title: event.postModel.title,
            content: event.postModel.content,
            comments: [],
          ),
        );

        serviceState = state.copyWith(
          event: UserServiceEvents.createPostSuccess,
          loading: false,
          postModelList: posts,
        );
      } else {
        serviceState = state.copyWith(
          event: UserServiceEvents.createPostError,
          loading: false,
        );
      }
    } catch (e) {
      serviceState = state.copyWith(
        event: UserServiceEvents.createPostError,
        loading: false,
      );
    }
    yield serviceState;
  }

  Stream<UserServiceState> mapToPutCommentStart(dynamic event) async* {
    UserServiceState serviceState;

    yield state.copyWith(
      event: event.type,
      loading: true,
    );

    try {
      final res = await _userService.putComment(
        event.postModel.postID,
        event.commentModel,
      );

      if (res) {
        List<PostModel> currentPosts =
            List<PostModel>.from(state.postModelList);

        final postIndex = currentPosts.indexWhere(
          (post) => post == event.postModel,
        );

        var currentPost = currentPosts[postIndex];
        currentPost.comments.insert(0, event.commentModel.toJson());

        serviceState = state.copyWith(
          event: UserServiceEvents.putCommentSuccess,
          loading: false,
          postModel: currentPost,
          postModelList: currentPosts,
        );
      } else {
        serviceState = state.copyWith(
          event: UserServiceEvents.putCommentError,
          loading: false,
        );
      }
    } catch (e) {
      serviceState = state.copyWith(
        event: UserServiceEvents.putCommentError,
        loading: false,
      );
    }
    yield serviceState;
  }
}
