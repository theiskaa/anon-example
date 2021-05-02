import 'dart:async';

import 'package:anon/core/model/post.dart';
import 'package:anon/core/services/user_service.dart';
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
      case UserServiceEvents.createPostStart:
        yield* mapToCreatePostStart(event);
        break;
      case UserServiceEvents.getAllStart:
        yield* mapToGetAllStart(event);
        break;
      default:
    }
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
        final posts = List<PostModel>.from(state.postModelList);

        posts.insert(
          0,
          state.postModel.copyWith(
            userID: event.postModel.userID,
            title: event.postModel.title,
            content: event.postModel.content,
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

  Stream<UserServiceState> mapToGetAllStart(dynamic event) async* {
    UserServiceState serviceState;

    yield state.copyWith(
      event: event.type,
      loading: true,
    );

    try {
      state.postModelList.clear();

      final postsFromFirestore = await _userService.getPosts();

      await Future.delayed(Duration(seconds: 2));

      // List<PostModel> postModelList =
      //     await _userService.saveAndGetPostsFromLocal(postsFromFirestore);

      serviceState = state.copyWith(
        event: UserServiceEvents.getAllSuccess,
        loading: false,
        postModelList: postsFromFirestore,
      );
    } catch (e) {
      serviceState = state.copyWith(
        event: UserServiceEvents.getAllError,
        loading: false,
      );
    }
    yield serviceState;
  }
}
