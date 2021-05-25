import 'package:anon/core/model/post.dart';
import 'package:anon/view/screens/pages/home/view_comments.dart';
import 'package:anon/view/screens/pages/home/view_post.dart';
import 'package:anon/view/widgets/anon_widgets.dart';
import 'package:anon/view/widgets/components/post_card.dart';
import 'package:anon/view/widgets/utils/route_with_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LazyLoadListView extends AnonStatefulWidget {
  final List<PostModel> defaultList;

  LazyLoadListView({@required this.defaultList});
  @override
  _LazyLoadListViewState createState() => _LazyLoadListViewState();
}

class _LazyLoadListViewState extends AnonState<LazyLoadListView> {
  ScrollController _controller = ScrollController();

  int currentMaxPostLength = 10;
  int _testMaxLength = 10;

  List<PostModel> udatedPosts;

  @override
  void initState() {
    super.initState();
    udatedPosts = widget.defaultList.getRange(0, currentMaxPostLength).toList();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent)
        _updatePosts();
    });
  }

  void _updatePosts() {
    if (_testMaxLength < widget.defaultList.length)
      setState(() => _testMaxLength = _testMaxLength + 10);

    if (_testMaxLength < widget.defaultList.length) {
      udatedPosts =
          widget.defaultList.getRange(0, currentMaxPostLength + 10).toList();
      setState(() => currentMaxPostLength = currentMaxPostLength + 10);
    } else {
      udatedPosts = widget.defaultList.take(widget.defaultList.length).toList();
      setState(() => currentMaxPostLength = widget.defaultList.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildContentList();
  }

  ListView buildContentList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: currentMaxPostLength,
        controller: _controller,
        itemBuilder: (context, index) {
          if (index == currentMaxPostLength - 1) return loadingAndEmptytitle();

          return buildListItem(index);
        });
  }

  buildListItem(int index) => Center(
        child: PostCardWidget(
          postModel: udatedPosts[index],
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ViewPost(postModel: udatedPosts[index]),
            ),
          ),
          onViewCommentsTap: () => Navigator.push(
            context,
            routeWithTransition(ViewComments(post: udatedPosts[index])),
          ),
        ),
      );

  loadingAndEmptytitle() => Padding(
        padding: const EdgeInsets.all(8),
        child: _testMaxLength > widget.defaultList.length
            ? buildEmptyTitle()
            : CupertinoActivityIndicator(radius: 15),
      );

  Center buildEmptyTitle() =>
      Center(child: Text("Couldn't find more posts..."));
}
