import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

import '../loading_bloc.dart';

class ALScaffoldSlivered extends StatelessWidget {
  const ALScaffoldSlivered({
    @required this.title,
    @required this.background,
    this.actions,
    this.floatingActionButton,
    this.floating = false,
    this.pinned = true,
    this.centerTitle = true,
    this.expandedHeight = 200.0,
    @required this.body,
  })  : assert(title != null),
        assert(background != null),
        assert(body != null);

  final Widget title;
  final Widget background;
  final List<Widget> actions;
  final Widget body;
  final bool floating;
  final bool pinned;
  final bool centerTitle;
  final double expandedHeight;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: actions,
              expandedHeight: expandedHeight,
              floating: floating,
              pinned: pinned,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: centerTitle,
                title: title,
                background: background,
              ),
            ),
          ];
        },
        body: StreamBuilder<LoadingState>(
          stream: BlocProvider.getBloc<LoadingBloc>().loadingState,
          builder: (_, snapshot) {
            if (snapshot.data == LoadingState.loading) {
              return const GGLoadingDoubleBounce(size: 20);
            }
            return body;
          },
        ),
      ),
    );
  }
}
