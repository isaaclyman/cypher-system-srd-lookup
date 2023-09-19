import 'dart:math';

import 'package:collection/collection.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';

class CResultsBlock extends StatefulWidget {
  final void Function(CSearchResult) onSelectResult;
  final Iterable<CSearchResultCategory> results;
  final String searchText;

  const CResultsBlock(
    this.results, {
    super.key,
    required this.onSelectResult,
    required this.searchText,
  });

  @override
  State<CResultsBlock> createState() => _CResultsBlockState();
}

class _CResultsBlockState extends State<CResultsBlock> {
  final Map<String, int> resultsToShow = {};

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: widget.results.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.error),
                  ),
                  Text(
                    "No results found.",
                  ),
                ],
              ),
            )
          : ListView(
              children: widget.results
                  .map((cat) => [
                        _CategoryHeader(text: cat.category),
                        ...cat.results
                            .slice(
                              0,
                              min(
                                  resultsToShow.putIfAbsent(
                                      cat.category, () => 10),
                                  cat.results.length),
                            )
                            .map((r) => _ResultItem(
                                  onTap: () {
                                    widget.onSelectResult(r);
                                  },
                                  result: r,
                                  searchText: widget.searchText,
                                )),
                        if (cat.results.length >
                            (resultsToShow[cat.category] ?? 10))
                          _LoadMoreResults(
                            categoryName: cat.category,
                            onLoadMore: () {
                              setState(() {
                                resultsToShow[cat.category] = resultsToShow
                                        .putIfAbsent(cat.category, () => 10) +
                                    10;
                              });
                            },
                            resultsShown: resultsToShow[cat.category] ?? 10,
                            totalResults: cat.results.length,
                          ),
                      ])
                  .flattened
                  .toList(),
            ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String text;

  const _CategoryHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 4,
        left: 8,
        right: 8,
        top: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          const Expanded(
            flex: 1,
            child: Divider(
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              text,
              style: context.text.resultCategoryHeader,
            ),
          ),
          const Expanded(
            flex: 20,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultItem extends StatelessWidget {
  final String searchText;
  final CSearchResult result;
  final void Function() onTap;

  const _ResultItem({
    required this.result,
    required this.searchText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 6,
          left: 24,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                result.header,
                style: context.text.resultEntryHeader,
              ),
            ),
            _HighlightMatch(
              matchText: searchText,
              fullText: result.summary,
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadMoreResults extends StatelessWidget {
  final String categoryName;
  final void Function() onLoadMore;
  final int resultsShown;
  final int totalResults;

  const _LoadMoreResults({
    required this.categoryName,
    required this.onLoadMore,
    required this.resultsShown,
    required this.totalResults,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$resultsShown of $totalResults $categoryName results.",
            style: context.text.small,
          ),
          TextButton(
            onPressed: onLoadMore,
            child: Text(
              "Load More",
              style: context.text.small,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightMatch extends StatelessWidget {
  final String matchText;
  final String fullText;

  const _HighlightMatch({required this.matchText, required this.fullText});

  @override
  Widget build(BuildContext context) {
    final fullMatchIx = fullText.toLowerCase().indexOf(matchText.toLowerCase());

    final minWindow = max(30, matchText.length);
    String windowedText;
    if (minWindow >= fullText.length || fullMatchIx <= minWindow) {
      windowedText = fullText;
    } else if (fullMatchIx >= fullText.length - minWindow) {
      windowedText = "...${fullText.substring(fullText.length - minWindow)}";
    } else {
      windowedText = "...${fullText.substring(fullMatchIx - minWindow ~/ 2)}";
    }

    final windowMatchIx =
        windowedText.toLowerCase().indexOf(matchText.toLowerCase());

    return windowMatchIx == -1
        ? Text.rich(TextSpan(text: windowedText))
        : Text.rich(
            TextSpan(children: [
              TextSpan(
                text: windowedText.substring(0, windowMatchIx),
              ),
              TextSpan(
                text: windowedText.substring(
                    windowMatchIx, windowMatchIx + matchText.length),
                style: context.text.highlight,
              ),
              TextSpan(
                text: windowedText.substring(windowMatchIx + matchText.length),
              ),
            ]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
  }
}
