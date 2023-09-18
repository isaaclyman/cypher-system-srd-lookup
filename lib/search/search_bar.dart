import 'package:flutter/material.dart';

import 'package:cypher_system_srd_lookup/theme/colors.dart';

class CSearchBar extends StatefulWidget {
  final void Function(bool) onFocusChange;
  final void Function(String) onValueChange;

  const CSearchBar({
    super.key,
    required this.onFocusChange,
    required this.onValueChange,
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
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChange?.call(_focusNode.hasFocus);
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
    return TextField(
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
      ),
      focusNode: _focusNode,
      onChanged: widget.onValueChange,
    );
  }
}
