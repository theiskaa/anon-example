import 'dart:math';

import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/model/post.dart';
import 'package:anon/core/utils/fire.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/markdown_editbar.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatePost extends AnonStatefulWidget {
  final int segmentedValue;
  CreatePost({this.segmentedValue = 0});
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends AnonState<CreatePost> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var random = Random();

  String previewString = '';

  UserserviceBloc _userserviceBloc;

  int segmentedValue = 0;
  final views = const <int, Widget>{0: Text('Create'), 1: Text('Preview')};

  final postColors = const [
    "#F5EEF8",
    "#E8F8F5",
    "#EBF5FB",
    "#EAFAF1",
    "#FEF9E7",
    "#FDFEFE",
    "#FDFEFE",
    "#FDFEFE",
  ];

  @override
  void initState() {
    segmentedValue = widget.segmentedValue;
    _userserviceBloc = BlocProvider.of<UserserviceBloc>(context);
    super.initState();
  }

  void _createPostAndPublish() {
    if (formKey.currentState.validate()) {
      if (segmentedValue == 1 && _titleController.text.length < 3)
        setState(() => segmentedValue = 0);
      else {
        var randomColorIndex = random.nextInt(postColors.length);

        var post = PostModel(
          userID: fireauthInstance.currentUser.uid ?? "Anon",
          content: _contentController.text,
          title: _titleController.text,
          color: postColors[randomColorIndex],
        );

        _userserviceBloc.add(UserServiceEvent.createPostStart(post));

        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        onLeadingTap: () => Navigator.pop(context),
        centerWidget: CupertinoSlidingSegmentedControl(
          groupValue: segmentedValue,
          children: views,
          backgroundColor: Colors.black,
          onValueChanged: (i) {
            setState(() => segmentedValue = i);
          },
        ),
        actions: [
          CreateButton(
            key: Key('create.button'),
            onTap: _createPostAndPublish,
          ),
        ],
      ),
      bottomNavigationBar: segmentedValue == 0
          ? MarkdownEditBar(controller: _contentController)
          : null,
      body: formBody(),
    );
  }

  Widget formBody() => Form(
        key: formKey,
        child: segmentedValue == 0 ? create : preview,
      );

  Widget get preview => SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              _titleController.text,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 20),
            divider,
            SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              child: MarkdownBody(
                data: previewString,
                selectable: true,
                onTapLink: (text, href, title) => launch(href),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      );

  Widget get create {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              key: Key('title.field'),
              controller: _titleController,
              textInputAction: TextInputAction.continueAction,
              decoration: _customFieldDecoration('Content title'),
              validator: (val) =>
                  (val.isEmpty) ? "Title can't be empty!" : null,
            ),
            SizedBox(height: 20),
            divider,
            SizedBox(height: 20),
            TextField(
              maxLines: 50,
              controller: _contentController,
              textInputAction: TextInputAction.newline,
              decoration:
                  _customFieldDecoration('Content description as Markdown'),
              onChanged: (val) => setState(() => previewString = val),
            ),
          ],
        ),
      ),
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
