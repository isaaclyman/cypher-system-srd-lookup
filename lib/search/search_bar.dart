import 'package:cypher_system_srd_lookup/events/event_handler.dart';
import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:cypher_system_srd_lookup/util/intersperse.dart';
import 'package:flutter/material.dart';

import 'package:cypher_system_srd_lookup/theme/colors.dart';
import 'package:provider/provider.dart';

class CSearchBar extends StatefulWidget {
  final void Function(bool) onFocusChange;

  const CSearchBar({
    super.key,
    required this.onFocusChange,
  });

  @override
  State<CSearchBar> createState() => _CSearchBarState();
}

class _CSearchBarState extends State<CSearchBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

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
    return Consumer<CEventHandler>(
      builder: (_, handler, ___) => TextField(
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
    );
  }
}

class CSearchFilters extends StatefulWidget {
  const CSearchFilters({super.key});

  @override
  State<CSearchFilters> createState() => _CSearchFiltersState();
}

class _CSearchFiltersState extends State<CSearchFilters> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.transparent,
            Colors.transparent,
            Colors.white
          ],
          stops: [0.0, 0.02, 0.9, 1.0],
        ).createShader(rect),
        blendMode: BlendMode.dstOut,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            child: Consumer2<CEventHandler, CSearchManager>(
              builder: (_, handler, searchManager, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: searchManager.filterState.entries
                    .map<Widget>(
                      (kvp) => FilterChip(
                        label: Text(kvp.key),
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                        labelStyle: context.text.filterChip,
                        selected: kvp.value,
                        onSelected: (value) {
                          final newFilters =
                              Map<String, bool>.from(searchManager.filterState);
                          newFilters[kvp.key] = value;
                          handler.setSearchFilters(newFilters);
                        },
                      ),
                    )
                    .intersperse(
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
