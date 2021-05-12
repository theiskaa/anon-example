import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/core/services/user_service.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/components/post_card.dart';
import 'package:anon/view/widgets/utils/route_with_transition.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view_comments.dart';
import 'view_post.dart';

class Me extends AnonStatefulWidget {
  Me({Key key}) : super(key: key);

  @override
  _MeState createState() => _MeState();
}

class _MeState extends AnonState<Me> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithLogo(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: OpacityButton(
              key: Key('logout.button'),
              child: Icon(Icons.logout, color: Colors.black),
              onTap: () {
                BlocProvider.of<AuthBloc>(context).add(AuthEvent.logoutStart());
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<UserserviceBloc, UserServiceState>(
        builder: (context, state) {
          if (state.savedPosts.isEmpty) return emptyList();
          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(UserServiceState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 10),
          divider,
          SizedBox(height: 20),
          titleAndClearButton(),
          SizedBox(height: 20),
          posts(state)
        ],
      ),
    );
  }

  Container titleAndClearButton() {
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Favorite Posts:",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          OpacityButton(
            onTap: () async {
              await UserService().clearList();
              BlocProvider.of<UserserviceBloc>(context)
                  .add(UserServiceEvent.getSavedStart());
            },
            child: Text(
              "Clear all",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Column posts(UserServiceState state) {
    return Column(
      children: state.savedPosts
          .map(
            (post) => PostCardWidget(
              postModel: post,
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewPost(
                    postModel: post,
                    postIsSaved: true,
                  ),
                ),
              ),
              onViewCommentsTap: () => Navigator.push(
                context,
                routeWithTransition(ViewComments(
                  post: post,
                  postIsSaved: true,
                )),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget emptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied_outlined,
            size: 68,
            color: Colors.black,
          ),
          SizedBox(height: 15),
          Text("Couldn't found any favorited post")
        ],
      ),
    );
  }
}
