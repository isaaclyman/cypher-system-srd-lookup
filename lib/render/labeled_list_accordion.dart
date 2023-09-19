import 'package:cypher_system_srd_lookup/render/accordion.dart';
import 'package:cypher_system_srd_lookup/render/chip.dart';
import 'package:cypher_system_srd_lookup/render/name_description.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';

class CRenderLabeledListAccordion extends StatelessWidget {
  final String label;
  final String? innerLabel;
  final Iterable<CNameDescription> listItems;

  const CRenderLabeledListAccordion(
    this.listItems, {
    super.key,
    this.innerLabel,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CRenderAccordion(
      label: label,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (innerLabel != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                innerLabel!,
                style: context.text.accordionInnerLabel,
              ),
            ),
          ...listItems.map((it) => _LabeledListItem(it)).toList(),
        ],
      ),
    );
  }
}

class _LabeledListItem extends StatelessWidget {
  final CNameDescription item;

  const _LabeledListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: CRenderChip(item.name),
          ),
          Text(item.description),
        ],
      ),
    );
  }
}
