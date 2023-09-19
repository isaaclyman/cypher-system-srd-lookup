import 'package:cypher_system_srd_lookup/search/search_manager.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:flutter/material.dart';

class CFullEntry extends StatelessWidget {
  final CSearchResult result;

  const CFullEntry({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.category,
                      style: context.text.entryCategory,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        result.header,
                        style: context.text.entryMainHeader,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Scaffold.of(context).closeEndDrawer();
                },
                icon: const Icon(Icons.close),
                visualDensity: VisualDensity.compact,
              )
            ],
          ),
        ),
        const Divider(
          height: 6,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: result
                    .getRenderables()
                    .map((r) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: r,
                        ))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
