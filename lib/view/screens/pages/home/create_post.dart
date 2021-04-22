import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/markdown_editbar.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePost extends AnonStatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends AnonState<CreatePost> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  UserserviceBloc _userserviceBloc;

  @override
  void initState() {
    _userserviceBloc = BlocProvider.of<UserserviceBloc>(context);
    super.initState();
  }

  void _createPostAndPublish() {
    var post = PostModel(
      userID: fireauthInstance.currentUser.uid ?? "Anon",
      content: _contentController.text,
      title: _titleController.text,
    );

    _userserviceBloc.add(UserServiceEvent.createPostStart(post));

    if (_userserviceBloc.state.event == UserServiceEvents.createPostSuccess) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        onLeadingTap: () => Navigator.pop(context),
        actions: [CreateButton(onTap: _createPostAndPublish)],
      ),
      bottomNavigationBar: MarkdownEditBar(controller: _contentController),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: fields(),
        ),
      ),
    );
  }

  Column fields() {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          textInputAction: TextInputAction.continueAction,
          decoration: _customFieldDecoration('Content title'),
        ),
        SizedBox(height: 20),
        divider,
        SizedBox(height: 20),
        TextField(
          maxLines: 50,
          controller: _contentController,
          textInputAction: TextInputAction.newline,
          decoration: _customFieldDecoration('Content description as Markdown'),
        ),
      ],
    );
  }

  InputDecoration _customFieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }
}
