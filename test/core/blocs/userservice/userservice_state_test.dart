import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const postModel = PostModel(
    userID: 'empty',
    title: "title",
    content: 'content',
  );

  late UserServiceState userServiceState;

  setUpAll(() {
    // Initial version of UserServiceState.
    userServiceState = UserServiceState(
      event: UserServiceEvents.getAllStart,
      loading: true,
      postModel: postModel,
      savedPosts: [],
      postModelList: [],
    );
  });

  group("[UserServiceState]", () {
    test("Test if UserServiceState.copyWith(...) works", () {
      var newPostModel =
          postModel.copyWith(userID: 'id', title: 'tit', content: 'cont');

      // To test copyWith with default values.
      final defualtUserServiceState = userServiceState.copyWith();

      // To test copyWith with different values.
      final newUserServiceState = userServiceState.copyWith(
        event: UserServiceEvents.getAllSuccess,
        loading: false,
        postModel: newPostModel,
        savedPosts: [postModel],
        postModelList: [postModel],
      );

      expect(defualtUserServiceState.event, userServiceState.event);
      expect(defualtUserServiceState.loading, userServiceState.loading);
      expect(defualtUserServiceState.postModel, userServiceState.postModel);
      expect(
        defualtUserServiceState.postModelList,
        userServiceState.postModelList,
      );
      expect(defualtUserServiceState.savedPosts, userServiceState.savedPosts);

      expect(newUserServiceState.event, UserServiceEvents.getAllSuccess);
      expect(newUserServiceState.loading, false);
      expect(newUserServiceState.postModel, newPostModel);
      expect(newUserServiceState.postModelList, [postModel]);
      expect(newUserServiceState.savedPosts, [postModel]);
    });

    test("Test if UserServiceState.defaultState() works", () {
      UserServiceState defaultState = UserServiceState.defaultState();

      expect(defaultState.event, null);
      expect(defaultState.loading, true);
      expect(defaultState.postModel, const PostModel());
      expect(defaultState.savedPosts, const <PostModel>[]);
      expect(defaultState.postModelList, const <PostModel>[]);
    });
  });
}
