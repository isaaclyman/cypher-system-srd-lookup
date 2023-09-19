import 'package:cypher_system_srd_lookup/events/event_handler.dart';
import 'package:cypher_system_srd_lookup/json_data/json_types.dart';
import 'package:cypher_system_srd_lookup/json_data/read_json.dart';
import 'package:cypher_system_srd_lookup/search/full_entry.dart';
import 'package:cypher_system_srd_lookup/search/results.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/search/search_bar.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp(dataRoot: await readSrdJson()));
}

class MainApp extends StatefulWidget {
  final CJsonRoot dataRoot;
  final CSearchManager searchManager;

  MainApp({
    super.key,
    required this.dataRoot,
  }) : searchManager = CSearchManager(dataRoot);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final CEventHandler eventHandler;

  bool isSearchBarFocused = false;

  late void Function() debouncedSearch;

  @override
  void initState() {
    super.initState();
    eventHandler = CEventHandler(searchManager: widget.searchManager);
    widget.searchManager.addListener(onSearchUpdate);
  }

  @override
  void dispose() {
    widget.searchManager.removeListener(onSearchUpdate);
    super.dispose();
  }

  void onSearchUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: MultiProvider(
        providers: [
          Provider<CEventHandler>(
            create: (_) => eventHandler,
          ),
          ChangeNotifierProvider<CSearchManager>(
            create: (_) => widget.searchManager,
          )
        ],
        child: Scaffold(
          body: AnimatedAlign(
            alignment: isSearchBarFocused || widget.searchManager.hasResults
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
                  filters: widget.dataRoot.searchables
                      .map((s) => s.category)
                      .toList(),
                ),
                if (widget.searchManager.searchText.isNotEmpty)
                  Expanded(
                    child: Builder(builder: (context) {
                      return CResultsBlock(
                        widget.searchManager.results,
                        onSelectResult: (result) {
                          setState(() {
                            widget.searchManager.selectResult(result);
                            Scaffold.of(context).openEndDrawer();
                          });
                        },
                        searchText: widget.searchManager.searchText,
                      );
                    }),
                  )
              ],
            ),
          ),
          endDrawer: widget.searchManager.selectedResult != null
              ? Drawer(
                  child:
                      CFullEntry(result: widget.searchManager.selectedResult!),
                )
              : null,
        ),
      ),
    );
  }
}

class _SearchBlock extends StatelessWidget {
  final void Function(bool) onFocusChange;
  final List<String> filters;

  const _SearchBlock({
    required this.onFocusChange,
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
