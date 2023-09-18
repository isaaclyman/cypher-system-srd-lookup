import 'package:collection/collection.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';

class CResultsBlock extends StatelessWidget {
  final Iterable<CSearchResultCategory> results;

  const CResultsBlock(this.results, {super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 650),
      child: ListView(
        children: results
            .map((cat) => [
                  _CategoryHeader(text: cat.category),
                  ...cat.results.map((r) => _ResultItem(result: r)),
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
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
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
              style: context.text.categoryHeader,
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
  final CSearchResultWithBody result;

  const _ResultItem({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: context.text.resultHeader,
            ),
          ),
          Text(
            result.body,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
