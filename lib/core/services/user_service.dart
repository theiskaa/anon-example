import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // ignore: unused_field
  static SharedPreferences _preferences;

  /// Method for create/publish post to content list.
  Future<bool> createPost({PostModel postModel}) async {
    try {
      await postsRef.doc().set({
        'title': postModel.title,
        'content': postModel.content,
        'userID': postModel.userID,
        'date': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Stream for get content list.
  Future<List<PostModel>> getPosts() async {
    final snapshot =
        await postsRef.orderBy('date', descending: true).limit(300).get();

    // Empty list for save converted data.
    List<PostModel> postModelList = [];

    snapshot.docs.forEach((post) async {
      var comments = await getComments(post.id);
      print(comments.length);
      // Convert each element of `snapshot.docs` to PostModel.
      var postModel = PostModel.fromSnapshot(post, comments);
      // print(comment);
      postModelList.add(postModel);
    });

    return postModelList;
  }

  Future<List<CommentModel>> getComments(final postID) async {
    // Empty list for save converted data.
    List<CommentModel> commentsList = [];

    final commentsSnapshot = await commentsRef(postID).get();

    commentsSnapshot.docs.forEach((comment) {
      var commentModel = CommentModel.fromSnapshot(comment);
      commentsList.add(commentModel);
    });

    return commentsList;
  }

  /// Function to save getted posts into local database.
  // Future<List<PostModel>> saveAndGetPostsFromLocal(
  //     List<PostModel> postsList) async {
  //   if (postsList.isEmpty || postsList == null)
  //     return [];
  //   else {
  //     // Initilaze instance of SharedPreferences.
  //     if (_preferences == null)
  //       _preferences = await SharedPreferences.getInstance();

  //     // Convert PostModel list to String.
  //     final encodedList = PostModel.encode(postsList);

  //     // Remove exiting list.
  //     await _preferences.remove(LocalDbKeys.postsList);

  //     // And save encoded list to string to local database.
  //     await _preferences.setString(LocalDbKeys.postsList, encodedList);

  //     // Get encoded/converted PostModel list from local database.
  //     final savedList = _preferences.getString(LocalDbKeys.postsList);

  //     // Decode/Convert saved string/list to List<PostModel>.
  //     final List<PostModel> decodedList = PostModel.decode(savedList);
  //     return decodedList;
  //   }
  // }
}
