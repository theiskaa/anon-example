import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  /// Method for create/publish post into content list.
  Future<bool> createPost({PostModel postModel}) async {
    try {
      await postsRef.doc().set({
        'postContent': postModel.content,
        'ID': postModel.id,
        'date': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
