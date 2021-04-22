import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
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
    // Get data by [postsRef].
    var snapshot = await postsRef.orderBy('date', descending: true).get();

    // Empty list for save converted data.
    List<PostModel> postModelList = [];

    snapshot.docs.forEach((element) {
      // Convert eached element of `snapshot.docs` to PostModelEntity.
      var postEntity = PostModelEntity.fromSnapshot(element);

      // Convert [PostModelEntity] to [PostModel].
      var postModel = PostModel.fromEntity(postEntity);

      postModelList.add(postModel);
    });

    return postModelList;
  }
}
