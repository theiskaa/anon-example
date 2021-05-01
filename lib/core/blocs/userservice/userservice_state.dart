part of 'userservice_bloc.dart';

@immutable
// ignore: must_be_immutable
class UserServiceState {
  final UserServiceEvents event;
  final bool loading;
  final PostModel postModel;
  List<PostModel> postModelList;

  UserServiceState({
    @required this.event,
    this.loading,
    this.postModel,
    this.postModelList,
  });

  UserServiceState copyWith({
    UserServiceEvents event,
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

  UserServiceState.defaultState()
      : this(
          event: null,
          loading: true,
          postModel: const PostModel(),
          postModelList: <PostModel>[],
        );
}
