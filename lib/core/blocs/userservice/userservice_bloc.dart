import 'dart:async';

import 'package:anon/core/model/post.dart';
import 'package:anon/core/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'userservice_event.dart';
part 'userservice_state.dart';

class UserserviceBloc extends Bloc<UserServiceEvent, UserServiceState> {
  final UserService userService;
  UserserviceBloc({this.userService}) : super(UserServiceState.defaultState());

  @override
  Stream<UserServiceState> mapEventToState(
    UserServiceEvent event,
  ) async* {
    switch (event.type) {
      case UserServiceEvents.createPostStart:
        UserServiceState serviceState;

        yield state.copyWith(
          event: event.type,
          loading: true,
        );

        try {
          final res = await userService.createPost(postModel: event.postModel);
          if (res) {
            final posts = List<PostModel>.from(state.postModelList);

            posts.add(state.postModel.copyWith(
              id: event.postModel.id,
              content: event.postModel.content,
            ));

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

        break;
      default:
    }
  }
}
