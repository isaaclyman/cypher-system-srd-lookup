import 'dart:math';

import 'package:collection/collection.dart';

class CSearchManager {
  final CHasSearchables root;

  CSearchManager(this.root);

  Iterable<CSearchResultCategory> search(String searchText) {
    if (searchText.trim().isEmpty) {
      return [];
    }

    final results = <String, CSearchResultCategory>{};

    for (var searchableList in root.searchables) {
      for (var searchable in searchableList) {
        final match = searchable.searchTextList.indexed.firstWhereOrNull(
            (it) => it.$2.toLowerCase().contains(searchText.toLowerCase()));
        if (match == null) {
          continue;
        }

        final (priority, matchingText) = match;
        final result = searchable.asSearchResult();
        final category = results.putIfAbsent(
          result.category,
          () => CSearchResultCategory(
            category: result.category,
            results: [],
          ),
        );
        category.addResult(CSearchResultWithBody.fromCSearchResult(
            result, matchingText, priority));
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
  final List<CSearchResultWithBody> results;
  int minPriority = 100;

  CSearchResultCategory({
    required this.category,
    required this.results,
  });

  void addResult(CSearchResultWithBody result) {
    minPriority = min(minPriority, result.priority);
    results.add(result);
  }
}

class CSearchResultWithBody {
  final String category;
  final String header;
  final String body;
  final int priority;

  CSearchResultWithBody({
    required this.category,
    required this.header,
    required this.body,
    required this.priority,
  });

  CSearchResultWithBody.fromCSearchResult(
    CSearchResult result,
    String body,
    int priority,
  ) : this(
          category: result.category,
          header: result.header,
          body: body,
          priority: priority,
        );
}

class CSearchResult {
  final String category;
  final String header;

  CSearchResult({
    required this.category,
    required this.header,
  });
}

//
// INTERFACES
//

abstract class CHasSearchables {
  List<List<CSearchable>> get searchables;
}

abstract class CSearchable {
  Iterable<String> get searchTextList;
  CSearchResult asSearchResult();
}

abstract class CSearchableItem {
  String get searchText;
}
