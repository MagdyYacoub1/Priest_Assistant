import 'package:flutter/material.dart';
import 'package:priest_assistant/entities/confessor.dart';
import 'package:priest_assistant/widgets/search_tile.dart';

import '../entities/confessor_utilities.dart';
import 'empty_list_placeholder.dart';

class AppSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: Icon(
          Icons.clear_rounded,
          size: 30.0,
          semanticLabel: 'search For Confessor',
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(
        Icons.adaptive.arrow_back_rounded,
        size: 30.0,
        semanticLabel: 'search For Confessor',
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Confessor> filteredList = ConfessorUtilities.searchFilter(query);
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return SearchTile(
                myConfessor: filteredList[index],
              );
            },
          )
        : EmptyListPlaceholder();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Confessor> filteredList = ConfessorUtilities.searchFilter(query);
    return filteredList.isNotEmpty
        ? ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return SearchTile(
                myConfessor: filteredList[index],
              );
            },
          )
        : EmptyListPlaceholder();
  }
}
