import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:rebloc/rebloc.dart';
import 'package:test_lanars/blocs/app/mutating/side_effect_actions.dart';

class ScaffoldWithSearchBar extends StatefulWidget {
  final DispatchFunction dispatcher;
  final Widget body;

  const ScaffoldWithSearchBar({
    Key key,
    @required this.dispatcher,
    @required this.body,
  })  : assert(dispatcher != null),
        assert(body != null),
        super(key: key);

  @override
  _ScaffoldWithSearchBarState createState() => _ScaffoldWithSearchBarState();
}

class _ScaffoldWithSearchBarState extends State<ScaffoldWithSearchBar> {
  SearchBar searchBar;

  @override
  initState() {
    super.initState();
    searchBar = SearchBar(
      inBar: false,
      closeOnSubmit: false,
      clearOnSubmit: false,
      buildDefaultAppBar: buildAppBar,
      setState: setState,
      onSubmitted: onSubmittedSearch,
      onClosed: onSearchClosed,
    );
  }

  onSubmittedSearch(String query) {
    if (query.isNotEmpty) widget.dispatcher(StartSearch(query));
  }

  onSearchClosed() {
    widget.dispatcher(const EndSearch());
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("Unsplash feed"),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: widget.body,
    );
  }
}
