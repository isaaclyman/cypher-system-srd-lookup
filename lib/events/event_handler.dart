import 'package:cypher_system_srd_lookup/events/error_toast.dart';
import 'package:cypher_system_srd_lookup/pages/page_search.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/util/debounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CEventHandler {
  final CSearchManager searchManager;
  late final void Function() debouncedSearch;

  CEventHandler({required this.searchManager}) {
    debouncedSearch = cDebounce(
      const Duration(milliseconds: 150),
      () => searchManager.search(),
    );
  }

  void closeDrawer(BuildContext context) {
    Scaffold.of(context).closeEndDrawer();
  }

  void goToResult(
    BuildContext context,
    String? searchableCategoryName,
    String itemName,
  ) {
    final result = searchManager.getResult(searchableCategoryName, itemName);
    if (result != null) {
      searchManager.selectResult(context, result);
    } else {
      Future.microtask(() => ScaffoldMessenger.of(context)
          .showSnackBar(cErrorToast("Couldn't find that item (bad link).")));
    }
  }

  void setSearchFilters(Map<String, bool> filterState) {
    searchManager.filterState = filterState;
    debouncedSearch();
  }

  void setSearchQuery(BuildContext context, String query) {
    searchManager.searchText = query;
    debouncedSearch();
    context.goNamed(CPageSearch.name);
  }
}
