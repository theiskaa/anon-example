import 'dart:convert';

import 'package:anon/core/model/comment.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:anon/core/utils/localdb_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static SharedPreferences _preferences;

  /// Method for create/publish post to content list.
  Future<bool> createPost({PostModel postModel}) async {
    final post = postsRef.doc();

    try {
      await post.set({
        'postID': post.id,
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

      // Convert each element of `snapshot.docs` to PostModel.
      var postModel = PostModel.fromSnapshot(post, comments);
      // print(comment);
      postModelList.add(postModel);
    });

    await Future.delayed(Duration(seconds: 2));

    return postModelList;
  }

  /// Function to save getted posts into local database.
  Future<List<PostModel>> getCachedPosts() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();

    // Get cached posts from local database.
    final _cachedListAsString =
        _preferences.getStringList(LocalDbKeys.postsList);

    List<PostModel> postModelList = [];

    try {
      for (var i = 0; i < _cachedListAsString.length; i++) {
        _cachedListAsString.map((element) async {
          // Decode element  (convert string to map).
          // We do that because, we need Map for create a post model from json.
          Map decodedElement = await jsonDecode(element);

          // Create post from decoded element.
          PostModel post = PostModel.fromJson(decodedElement);

          postModelList.add(post);
        }).toList();
      }

      return postModelList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> cachePosts(List<PostModel> postList,
      {bool clearPostsFirst = false}) async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();

    if (clearPostsFirst == true) {
      _preferences.remove(LocalDbKeys.postsList);
    }

    // Convert [postList] to <String> list.
    List<String> encodedPosts =
        postList.map((post) => jsonEncode(post.toJson())).toList();
    await _preferences.setStringList(LocalDbKeys.postsList, encodedPosts);
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

  /// Method for put a comment to selected post list.
  Future<bool> putComment(final postID, {CommentModel commentModel}) async {
    try {
      await commentsRef(postID).doc().set({
        'title': commentModel.title,
        'date': Timestamp.now(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
