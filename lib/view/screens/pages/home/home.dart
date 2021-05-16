import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anon/core/blocs/userservice/userservice_bloc.dart';
import 'package:anon/view/screens/pages/home/create_post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/appbars.dart';
import 'package:anon/view/widgets/components/create_button.dart';
import 'package:anon/view/widgets/components/lazyload_listview.dart';
import 'package:anon/view/widgets/components/opacity_button.dart';
import 'package:anon/view/widgets/utils/route_with_transition.dart';
import 'package:anon/view/widgets/utils/widget_utils.dart';

class Home extends AnonStatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends AnonState<Home> {
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
        return Scaffold(appBar: _appbar(context), body: buildRightBody(state));
      },
    );
  }

  Widget buildRightBody(UserServiceState state) {
    if (state.loading ||
        state.postModelList.length == 0 &&
            state.event == UserServiceEvents.getAllStart ||
        state.event == UserServiceEvents.getAllStart ||
        state.event == UserServiceEvents.createPostStart) {
      return loadingIndicator;
    }

    if (state.event == UserServiceEvents.getAllError ||
        state.event == UserServiceEvents.createPostError) {
      return errorModal();
    }

    return _buildRefreshableBody(state);
  }

  RefreshIndicator _buildRefreshableBody(UserServiceState state) {
    return RefreshIndicator(
      backgroundColor: Colors.black,
      color: Colors.white,
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: LazyLoadListView(defaultList: state.postModelList),
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
            "Oops.. Something went wrong",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          OpacityButton(
            onTap: _refresh,
            child: Text(
              "Try again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    return SearchBar(
      posts: BlocProvider.of<UserserviceBloc>(context).state.postModelList,
      action: CreateButton(
        key: Key('create.button'),
        onTap: () => Navigator.push(
          context,
          routeWithTransition(CreatePost()),
        ),
      ),
    );
  }
}
