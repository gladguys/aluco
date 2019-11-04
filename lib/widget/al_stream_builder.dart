import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'al_error.dart';

class ALStreamBuilder<T> extends StatelessWidget {
  const ALStreamBuilder({
    Key key,
    @required this.stream,
    @required this.mainWidget,
    this.loadingIndicator = const ALWaitingIndicator(),
    this.errorIndicator = const ALError(),
  })  : assert(stream != null),
        assert(mainWidget != null),
        super(key: key);

  final Stream stream;
  final Widget Function(dynamic snapshotData) mainWidget;
  final Widget loadingIndicator;
  final Widget errorIndicator;

  @override
  Widget build(BuildContext context) {
    return GGStreamBuilder<T>(
      stream: stream,
      mainWidget: mainWidget,
      loadingIndicator: loadingIndicator,
      errorIndicator: errorIndicator,
    );
  }
}
