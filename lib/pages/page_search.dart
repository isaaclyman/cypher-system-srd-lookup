import 'package:cypher_system_srd_lookup/search/results.dart';
import 'package:cypher_system_srd_lookup/search/search_bar.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CPageSearch extends StatefulWidget {
  const CPageSearch({super.key});

  @override
  State<CPageSearch> createState() => _CPageSearchState();
}

class _CPageSearchState extends State<CPageSearch> {
  bool isSearchBarFocused = false;

  @override
  Widget build(BuildContext context) {
    final searchManager = context.watch<CSearchManager>();

    return AnimatedAlign(
      alignment: isSearchBarFocused || searchManager.hasResults
          ? Alignment.topCenter
          : Alignment.center,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _SearchBlock(
            onFocusChange: (isFocused) => setState(() {
              isSearchBarFocused = isFocused;
            }),
          ),
          if (searchManager.searchText.isNotEmpty)
            Expanded(
              child: Builder(builder: (context) {
                return CResultsBlock(
                  searchManager.results,
                  searchText: searchManager.searchText,
                  noResultsMessage: "No results found.\nCheck your filters.",
                );
              }),
            )
        ],
      ),
    );
  }
}

class _SearchBlock extends StatelessWidget {
  final void Function(bool) onFocusChange;

  const _SearchBlock({
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: CSearchBar(
              onFocusChange: onFocusChange,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              "Compatible with the Cypher System",
              style: context.text.legal,
            ),
          ),
        ),
        const CSearchFilters(),
      ],
    );
  }
}
