import 'package:flutter/material.dart';

import 'delegate/custom_search_delegate.dart';

class ALSearchDelegateIcon<T> extends StatelessWidget {
  const ALSearchDelegateIcon(this.searchDelegate);

  final CustomSearchDelegate<T> searchDelegate;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: searchDelegate,
        );
      },
    );
  }
}
