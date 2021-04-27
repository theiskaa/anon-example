import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:anon/core/utils/localdb_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
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
    // Get data by [postsRef].
    final snapshot =
        await postsRef.orderBy('date', descending: true).limit(300).get();

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

    // List<PostModel> generatedPostModelList = List.generate(
    //   60,
    //   (index) => PostModel(
    //       userID: index.toString(),
    //       title: "Title $index",
    //       content: "Content $index"),
    // );
  }

  /// Function to save getted posts into local database.
  Future<List<PostModel>> saveAndGetPostsFromLocal(
      List<PostModel> postsList) async {
    // Initilaze instance of SharedPreferences.
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();

    // Convert PostModel list to String.
    final encodedList = PostModel.encode(postsList);

    // Save encoded/converted list/string to local database
    await _preferences.setString(LocalDbKeys.postsList, encodedList);

    // Get encoded/converted PostModel list from local database.
    final savedList = _preferences.getString(LocalDbKeys.postsList);

    // Decode/Convert saved string/list to List<PostModel>.
    final List<PostModel> decodedList = PostModel.decode(savedList);
    return decodedList;
  }
}
