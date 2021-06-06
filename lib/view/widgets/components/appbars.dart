import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_post.dart';
import 'package:anon/view/widgets/opacity_animator.dart';

import '../anon_widgets.dart';
import 'opacity_button.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  final List<PostModel?>? posts;
  final BoxController boxController;
  final Widget? action;

  SearchBar({
    Key? key,
    required this.posts,
    this.action,
    required this.boxController,
  }) : super(key: key);

  @override
  SearchBarState createState() => SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  bool isSearchingEnabled = false;
  final fieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: buildRightCenterWidget(context),
      actions: [
        searchButton(),
        (!isSearchingEnabled)
            ? OpacityAnimator(
                duration: Duration(milliseconds: 300),
                child: widget.action,
              )
            : SizedBox(width: 15),
      ],
    );
  }

  Center searchButton() {
    return Center(
      child: OpacityButton(
        key: Key('enable.searching.button'),
        onTap: () => setState(() => isSearchingEnabled = !isSearchingEnabled),
        child: Icon(
          !isSearchingEnabled
              ? CupertinoIcons.search_circle_fill
              : CupertinoIcons.clear_circled_solid,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget buildRightCenterWidget(BuildContext context) {
    if (isSearchingEnabled) return buildSearchField(context);

    return OpacityAnimator(
      duration: Duration(milliseconds: 300),
      child: Image.asset(
        'assets/anon-text-logo.png',
        key: Key('anon.logo'),
        height: 35,
      ),
    );
  }

  FieldSuggestion buildSearchField(BuildContext context) {
    return FieldSuggestion(
      key: Key("search.field"),
      boxController: widget.boxController,
      hint: "Search by post title",
      textController: fieldController,
      suggestionList: widget.posts!,
      wDivider: true,
      onItemSelected: (dynamic post) => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ViewPost(postModel: post),
        ),
      ),
    );
  }
}

class AppBarWithLogo extends AnonStatelessWidget with PreferredSizeWidget {
  final List<Widget>? actions;

  AppBarWithLogo({
    Key? key,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Image.asset(
        'assets/anon-text-logo.png',
        key: Key('anon.logo'),
        height: 35,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class DefaultAppBar extends AnonStatelessWidget with PreferredSizeWidget {
  final Function? onLeadingTap;
  final Widget? centerWidget;
  final List<Widget>? actions;

  DefaultAppBar({
    Key? key,
    this.actions,
    this.centerWidget,
    this.onLeadingTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: centerWidget,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: actions,
      leading: OpacityButton(
        key: Key("go.back.button"),
        child: Icon(
          Icons.arrow_back_ios_outlined,
          color: Colors.black,
        ),
        onTap: onLeadingTap as void Function()? ??
            () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              Navigator.pop(context);
            },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(55);
}
