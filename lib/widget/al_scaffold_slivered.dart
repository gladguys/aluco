import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

import '../core/bloc/loading_bloc.dart';

class ALScaffoldSlivered extends StatelessWidget {
  const ALScaffoldSlivered({
    @required this.title,
    @required this.background,
    this.actions,
    this.floatingActionButton,
    this.floating = false,
    this.snap = false,
    this.pinned = true,
    this.forceElevated = true,
    this.centerTitle = true,
    this.expandedHeight = 200.0,
    @required this.body,
  })  : assert(title != null),
        assert(background != null),
        assert(body != null);

  final String title;
  final Widget background;
  final List<Widget> actions;
  final Widget body;
  final bool floating;
  final bool snap;
  final bool pinned;
  final bool forceElevated;
  final bool centerTitle;
  final double expandedHeight;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverLayoutBuilder(
              builder: (BuildContext context, SliverConstraints constraints) {
            final bool isExpanding = constraints.scrollOffset < 140;
            final bool isExpandingMedium = constraints.scrollOffset < 100;

            return SliverAppBar(
              iconTheme: isExpandingMedium
                  ? IconThemeData(
                      color: Colors.white,
                    )
                  : null,
              actionsIconTheme: isExpandingMedium
                  ? IconThemeData(
                      color: Colors.white,
                    )
                  : null,
              actions: actions,
              expandedHeight: expandedHeight,
              floating: floating,
              snap: snap,
              pinned: pinned,
              forceElevated: forceElevated,
              title: isExpanding
                  ? null
                  : Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              centerTitle: centerTitle,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(0),
                centerTitle: centerTitle,
                title: isExpanding
                    ? Container(
                        padding: const EdgeInsets.fromLTRB(32, 4, 32, 8),
                        child: Text(
                          title,
                          style: TextStyle(
                            color: Colors.orange,
                            shadows: isExpandingMedium
                                ? <BoxShadow>[
                                    const BoxShadow(offset: Offset(0, 1)),
                                  ]
                                : null,
                          ),
                        ),
                        decoration: isExpandingMedium
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black26,
                                    Colors.black45,
                                    Colors.black26,
                                    Colors.transparent,
                                  ],
                                ),
                              )
                            : null,
                      )
                    : null,
                background: background,
              ),
            );
          }),
          StreamBuilder<LoadingState>(
            stream: BlocProvider.getBloc<LoadingBloc>().loadingState,
            builder: (_, snapshot) {
              if (snapshot.data == LoadingState.loading) {
                return const SliverFillRemaining(
                    child: GGLoadingDoubleBounce(size: 20));
              }
              return body;
            },
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
