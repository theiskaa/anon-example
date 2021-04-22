import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/blocs/auth/auth_bloc.dart';
import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbar_with_logo.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/components/post_card.dart';

class Home extends AnonStatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends AnonState<Home> {
  UserserviceBloc _userserviceBloc;

  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _userserviceBloc = BlocProvider.of<UserserviceBloc>(context);
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
        return Scaffold(
          appBar: _appbar(context),
          body: _buildRefreshableBody(),
        );
      },
    );
  }

  RefreshIndicator _buildRefreshableBody() {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      color: Colors.white,
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: BlocBuilder<UserserviceBloc, UserServiceState>(
        builder: (context, state) {
          if (state.event == UserServiceEvents.getAllError) {
            return errorModal();
          }
          return buildContentList(state);
        },
      ),
    );
  }

  ListView buildContentList(UserServiceState state) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 20),
        Column(
          children: state.postModelList
              .map(
                (postModel) => PostCardWidget(
                  postModel: postModel,
                  onTap: () {},
                  onViewCommentsTap: () {},
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Center errorModal() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/warning.png',
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
          onTap: () {},
        ),
      ],
    );
  }
}
