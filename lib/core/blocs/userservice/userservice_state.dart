part of 'userservice_bloc.dart';

@immutable
class UserServiceState {
  final UserServiceEvents event;
  final bool loading;
  final PostModel postModel;
  final List<PostModel> postModelList;

  const UserServiceState({
    @required this.event,
    this.loading,
    this.postModel,
    this.postModelList,
  });

  UserServiceState copyWith({
    @required event,
    bool loading,
    PostModel postModel,
    List<PostModel> postModelList,
  }) =>
      UserServiceState(
        event: event ?? this.event,
        loading: loading ?? this.loading,
        postModel: postModel ?? this.postModel,
        postModelList: postModelList ?? this.postModelList,
      );

  const UserServiceState.defaultState()
      : this(
          event: null,
          loading: true,
          postModel: const PostModel(),
          postModelList: const <PostModel>[],
        );
}
