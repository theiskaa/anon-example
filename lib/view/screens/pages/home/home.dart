import 'dart:async';

import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/create_post.dart';
import 'package:anon/view/widgets/utils/route_with_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/components/post_card.dart';

class Home extends AnonStatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends AnonState<Home> {
  UserserviceBloc _userserviceBloc;

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final _scrollController = ScrollController();

  int currentMaxPostLength = 10;

  List<PostModel> posts;

  @override
  void initState() {
    super.initState();
    _userserviceBloc = BlocProvider.of<UserserviceBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getList();
      }
    });
  }

  void _getList() {
    if (_userserviceBloc.state.postModelList.length != posts.length) {
      posts = _userserviceBloc.state.postModelList
          .getRange(0, currentMaxPostLength + 10)
          .toList();
      print("Yihuuuuuu");
      setState(() {
        currentMaxPostLength = currentMaxPostLength + 10;
      });
    }
  }

  Future<void> _refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    _userserviceBloc.add(UserServiceEvent.getAllStart());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserserviceBloc, UserServiceState>(
      builder: (context, state) {
        posts = state.postModelList.take(currentMaxPostLength).toList();
        return Scaffold(
          appBar: _appbar(context),
          body: posts.length == 0
              ? Container()
              // ? Center(child: CupertinoActivityIndicator(radius: 25))
              : _buildRefreshableBody(state),
        );
      },
    );
  }

  RefreshIndicator _buildRefreshableBody(UserServiceState state) {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      color: Colors.white,
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: (state.event == UserServiceEvents.getAllError)
          ? errorModal()
          : buildContentList(state),
    );
  }

  ListView buildContentList(UserServiceState state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: currentMaxPostLength,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == posts.length) {
          return CupertinoActivityIndicator(radius: 15);
        }
        return Column(
          children: [
            PostCardWidget(
              postModel: posts[index],
              onTap: () {},
              onViewCommentsTap: () {},
            ),
          ],
        );
      },
    );
  }

  Center errorModal() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/warning.png',
            key: Key('warning.image'),
            height: 80,
          ),
          SizedBox(height: 20),
          Text(
            "Oops.. Something went wrong, please try again",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  AppBarWithLogo _appbar(BuildContext context) {
    return AppBarWithLogo(
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
        CreateButton(
          key: Key('create.button'),
          onTap: () =>
              Navigator.push(context, routeWithTransition(CreatePost())),
        ),
      ],
    );
  }
}
