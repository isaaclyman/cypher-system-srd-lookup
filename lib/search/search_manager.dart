import 'package:cypher_system_srd_lookup/json_data/json_types.dart';

class CSearchManager {
  final CJsonRoot srdRoot;

  CSearchManager(this.srdRoot);

  Iterable<CSearchResultCategory> search(
    String searchText, {
    int resultLimit = 10,
  }) {
    final results = <String, CSearchResultCategory>{};
    var resultsFound = 0;

    for (var searchableList in srdRoot.searchables) {
      if (resultsFound >= resultLimit) {
        break;
      }

      for (var searchable in searchableList) {
        if (resultsFound >= resultLimit) {
          break;
        }

        final matchingTexts = searchable.searchTextList.where((element) =>
            element.toLowerCase().contains(searchText.toLowerCase()));
        if (matchingTexts.isEmpty) {
          continue;
        }

        resultsFound++;
        final result = searchable.asSearchResult();
        final category = results.putIfAbsent(
          result.category,
          () => CSearchResultCategory(
            category: result.category,
            results: [],
          ),
        );
        category.results.add(CSearchResultWithBody.fromCSearchResult(
            result, matchingTexts.join("\n")));
      }
    }

    return results.values;
  }
}

class CSearchResultCategory {
  final String category;
  final List<CSearchResultWithBody> results;

  CSearchResultCategory({
    required this.category,
    required this.results,
  });
}

class CSearchResultWithBody {
  final String category;
  final String header;
  final String body;

  CSearchResultWithBody({
    required this.category,
    required this.header,
    required this.body,
  });

  CSearchResultWithBody.fromCSearchResult(CSearchResult result, String body)
      : this(category: result.category, header: result.header, body: body);
}

class CSearchResult {
  final String category;
  final String header;

  CSearchResult({
    required this.category,
    required this.header,
  });
}

abstract class CSearchable {
  Iterable<String> get searchTextList;
  CSearchResult asSearchResult();
}

abstract class CSearchableItem {
  String get searchText;
}
