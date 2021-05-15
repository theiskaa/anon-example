import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/view/screens/pages/home/view_post.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/opacity_animator.dart';
import 'package:field_suggestion/field_suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../anon_widgets.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  final Widget action;

  SearchBar({
    Key key,
    this.action,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _SearchBarState extends State<SearchBar>
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
        onTap: () => setState(() => isSearchingEnabled = !isSearchingEnabled),
        child: Icon(
          !isSearchingEnabled
              ? CupertinoIcons.search_circle_fill
              : CupertinoIcons.clear,
          color: Colors.black,
          size: isSearchingEnabled ? 20 : 30,
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
      hint: "Search by post title",
      textController: fieldController,
      suggestionList:
          BlocProvider.of<UserserviceBloc>(context).state.postModelList,
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
  final List<Widget> actions;

  AppBarWithLogo({
    Key key,
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
  final Function onLeadingTap;
  final Widget centerWidget;
  final List<Widget> actions;

  DefaultAppBar({
    Key key,
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
        onTap: onLeadingTap ??
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
