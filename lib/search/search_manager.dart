import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CSearchManager {
  final CHasSearchables root;

  CSearchManager(this.root);

  Iterable<CSearchResultCategory> search(
    String searchText,
    Map<String, bool> filterState,
  ) {
    if (searchText.trim().isEmpty) {
      return [];
    }

    final results = <String, CSearchResultCategory>{};

    for (var searchableCategory in root.searchables) {
      final category = searchableCategory.category;

      if (filterState[category] == false) {
        continue;
      }

      for (var searchable in searchableCategory.searchables) {
        final match = searchable.searchTextList.indexed.firstWhereOrNull(
            (it) => it.$2.toLowerCase().contains(searchText.toLowerCase()));
        if (match == null) {
          continue;
        }

        final (priority, matchingText) = match;
        final resultCategory = results.putIfAbsent(
          category,
          () => CSearchResultCategory(
            category: category,
            results: [],
          ),
        );
        resultCategory.addResult(
          CSearchResult(
            category: category,
            header: searchable.header,
            summary: matchingText,
            getRenderables: searchable.getRenderables,
            priority: priority,
          ),
        );
      }
    }

    for (var category in results.values) {
      category.results.sort((v1, v2) => v1.priority == v2.priority
          ? v1.header.compareTo(v2.header)
          : v1.priority.compareTo(v2.priority));
    }

    return results.values
        .sorted((v1, v2) => v1.minPriority == v2.minPriority
            ? v1.category.compareTo(v2.category)
            : v1.minPriority.compareTo(v2.minPriority))
        .reversed
        .toList();
  }
}

class CSearchResultCategory {
  final String category;
  final List<CSearchResult> results;
  int minPriority = 100;

  CSearchResultCategory({
    required this.category,
    required this.results,
  });

  void addResult(CSearchResult result) {
    minPriority = min(minPriority, result.priority);
    results.add(result);
  }
}

class CSearchResult {
  final String category;
  final String header;
  final String summary;
  final Iterable<Widget> Function() getRenderables;
  final int priority;

  CSearchResult({
    required this.category,
    required this.header,
    required this.summary,
    required this.getRenderables,
    required this.priority,
  });
}

//
// FOR DATA CLASSES
//

class CSearchableCategory {
  String category;
  List<CSearchable> searchables;

  CSearchableCategory({
    required this.category,
    required this.searchables,
  });
}

//
// INTERFACES
//

abstract class CHasSearchables {
  List<CSearchableCategory> get searchables;
}

abstract class CSearchable {
  String get header;
  Iterable<String> get searchTextList;
  Iterable<Widget> getRenderables();
}

abstract class CSearchableItem {
  String get searchText;
}
