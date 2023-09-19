import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CSearchManager extends ChangeNotifier {
  final CHasSearchables _root;

  String searchText = "";
  Map<String, bool> filterState = {};
  Iterable<CSearchResultCategory> results = [];
  bool get hasResults => results.isNotEmpty;

  CSearchResult? selectedResult;
  List<CSearchResult> pastResults = [];
  CSearchResult? get lastResult => pastResults.last;
  bool get canGoBack => pastResults.isNotEmpty;

  CSearchManager(this._root);

  void search() {
    results = _getResults();
    notifyListeners();
  }

  CSearchResult? getResult(String? searchableCategoryName, String itemName) {
    var searchableCategory = searchableCategoryName != null
        ? _root.searchables
            .firstWhereOrNull((cat) => cat.category == searchableCategoryName)
        : null;

    if (searchableCategory == null) {
      for (var category in _root.searchables) {
        var searchable = category.searchables
            .firstWhereOrNull((it) => it.header == itemName);
        if (searchable == null) {
          continue;
        }

        return CSearchResult(
          category: category.category,
          header: searchable.header,
          summary: itemName,
          getRenderables: searchable.getRenderables,
          priority: 0,
        );
      }

      return null;
    }

    var searchable = searchableCategory.searchables
        .firstWhereOrNull((it) => it.header == itemName);
    if (searchable == null) {
      return null;
    }

    return CSearchResult(
      category: searchableCategory.category,
      header: searchable.header,
      summary: itemName,
      getRenderables: searchable.getRenderables,
      priority: 0,
    );
  }

  void selectResult(CSearchResult? result) {
    if (selectedResult != null) {
      pastResults.add(selectedResult!);
    }

    selectedResult = result;
    notifyListeners();
  }

  void selectPreviousResult() {
    if (pastResults.isEmpty) {
      return;
    }

    selectedResult = pastResults.removeLast();
    notifyListeners();
  }

  Iterable<CSearchResultCategory> _getResults() {
    if (searchText.trim().isEmpty) {
      return [];
    }

    final results = <String, CSearchResultCategory>{};

    for (var searchableCategory in _root.searchables) {
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

abstract class CSearchableComplexItem {
  Iterable<String> get searchTextList;
  Iterable<Widget> getRenderables();
}
