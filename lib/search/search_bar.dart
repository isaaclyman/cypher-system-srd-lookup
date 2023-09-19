import 'package:cypher_system_srd_lookup/events/event_handler.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:flutter/material.dart';

import 'package:cypher_system_srd_lookup/theme/colors.dart';
import 'package:provider/provider.dart';

class CSearchBar extends StatefulWidget {
  final void Function(bool) onFocusChange;
  final List<String> filters;

  const CSearchBar({
    super.key,
    required this.onFocusChange,
    required this.filters,
  });

  @override
  State<CSearchBar> createState() => _CSearchBarState();
}

class _CSearchBarState extends State<CSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Map<String, bool> filterState = {};

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    filterState = {for (var filter in widget.filters) filter: true};

    context.read<CSearchManager>().addListener(_onSearchChange);
  }

  @override
  void dispose() {
    context.read<CSearchManager>().removeListener(_onSearchChange);
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChange() {
    _controller.text = context.read<CSearchManager>().searchText;
    // setState(() {
    // });
  }

  void _onFocusChange() {
    widget.onFocusChange.call(_focusNode.hasFocus);
  }

  OutlineInputBorder _border(double width) => OutlineInputBorder(
        borderSide: BorderSide(
          color: context.colors.primary,
          width: width,
        ),
        borderRadius: BorderRadius.circular(50),
      );

  @override
  Widget build(BuildContext context) {
    return Consumer2<CEventHandler, CSearchManager>(
      builder: (_, handler, searchManager, ___) => Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(
                border: _border(1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 6,
                ),
                enabledBorder: _border(1),
                focusedBorder: _border(2),
                labelText: "Search SRD",
                suffixIcon: _controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => setState(() {
                          _controller.clear();
                          handler.setSearchQuery("");
                        }),
                        tooltip: "Clear search",
                      ),
              ),
              focusNode: _focusNode,
              onChanged: (value) => handler.setSearchQuery(value),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 150),
            child: !_focusNode.hasFocus || _controller.text.isNotEmpty
                ? _FilterMenu(
                    filterState: filterState,
                    onFilterChange: (filter, checked) => setState(() {
                      filterState[filter] = checked;
                      handler.setSearchFilters(filterState);
                    }),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _FilterMenu extends StatefulWidget {
  final Map<String, bool> filterState;
  final void Function(String filter, bool checked) onFilterChange;

  const _FilterMenu({
    required this.filterState,
    required this.onFilterChange,
  });

  @override
  State<_FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<_FilterMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: widget.filterState.entries
          .map((kvp) => CheckboxMenuButton(
                closeOnActivate: false,
                onChanged: (checked) =>
                    widget.onFilterChange(kvp.key, checked ?? true),
                value: kvp.value,
                child: Text(kvp.key),
              ))
          .toList(),
      builder: (_, controller, ___) => IconButton(
        icon: const Icon(Icons.tune),
        onPressed: () {
          if (controller.isOpen) {
            controller.close();
          } else {
            controller.open();
          }
        },
        tooltip: "Set filters",
      ),
    );
  }
}
