import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

import '../core/bloc/linear_loading_bloc.dart';
import '../core/bloc/loading_bloc.dart';
import 'al_debug_http_button.dart';
import 'al_logout_button.dart';

class ALScaffold extends StatelessWidget {
  const ALScaffold({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.actions,
    this.floatingActionButton,
    @required this.body,
  })  : assert(title != null || titleWidget != null),
        assert(body != null);

  final String title;
  final Widget titleWidget;
  final String subtitle;
  final List<Widget> actions;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: titleWidget ??
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
            ),
        bottom: subtitle != null
            ? PreferredSize(
                preferredSize: const Size(300, 16),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            : null,
        actions: _getActions(),
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<LoadingState>(
            stream: BlocProvider.getBloc<LoadingBloc>().loadingState,
            builder: (_, snapshot) {
              if (snapshot.data == LoadingState.loading) {
                return const GGLoadingDoubleBounce(size: 20);
              }
              return body;
            },
          ),
          StreamBuilder<bool>(
            stream: BlocProvider.getBloc<LinearLoadingBloc>().loadingStream,
            initialData: false,
            builder: (_, snapshot) {
              return snapshot.data
                  ? Positioned.fill(
                      child: Container(
                        color: Colors.white70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            GGLoadingDoubleBounce(size: 48),
                            SizedBox(height: 12),
                            Text(
                              'Carregando...',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            },
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  List<Widget> _getActions() {
    if (kReleaseMode) {
      return actions;
    }
    return [...actions ?? [], ALDebugHttpButton(), ALLogoutButton()];
  }
}
