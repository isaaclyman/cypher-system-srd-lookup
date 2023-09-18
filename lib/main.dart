import 'package:cypher_system_srd_lookup/json_data/json_types.dart';
import 'package:cypher_system_srd_lookup/json_data/read_json.dart';
import 'package:cypher_system_srd_lookup/search/results.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/search/search_bar.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:cypher_system_srd_lookup/util/debounce.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp(dataRoot: await readSrdJson()));
}

class MainApp extends StatefulWidget {
  final CJsonRoot dataRoot;
  final CSearchManager manager;

  MainApp({
    super.key,
    required this.dataRoot,
  }) : manager = CSearchManager(dataRoot);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isSearchBarFocused = false;
  Iterable<CSearchResultCategory> results = [];
  bool get hasResults => results.isNotEmpty;
  String searchText = "";
  Map<String, bool> filterState = {};
  late void Function() debouncedSearch;

  @override
  void initState() {
    super.initState();

    debouncedSearch = cDebounce(
      const Duration(milliseconds: 150),
      () => setState(() {
        results = widget.manager.search(searchText, filterState);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: AnimatedAlign(
          alignment: isSearchBarFocused || hasResults
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
                onValueChange: (str, filterState) {
                  searchText = str;
                  this.filterState = filterState;
                  debouncedSearch();
                },
                filters:
                    widget.dataRoot.searchables.map((s) => s.category).toList(),
              ),
              if (hasResults)
                Expanded(
                  child: CResultsBlock(
                    results,
                    searchText: searchText,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBlock extends StatelessWidget {
  final void Function(bool) onFocusChange;
  final void Function(String, Map<String, bool>) onValueChange;
  final List<String> filters;

  const _SearchBlock({
    required this.onFocusChange,
    required this.onValueChange,
    required this.filters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: CSearchBar(
              onFocusChange: onFocusChange,
              onValueChange: onValueChange,
              filters: filters,
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
      ],
    );
  }
}
