import 'package:cypher_system_srd_lookup/events/event_handler.dart';
import 'package:cypher_system_srd_lookup/render/link.dart';
import 'package:cypher_system_srd_lookup/theme/text.dart';
import 'package:cypher_system_srd_lookup/util/intersperse.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CRenderLabeledSearchLinks extends StatelessWidget {
  final String label;
  final List<CLink> textQueries;

  const CRenderLabeledSearchLinks({
    super.key,
    required this.label,
    required this.textQueries,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CEventHandler>(
      builder: (_, handler, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (child != null) child,
          Expanded(
            child: Text.rich(
              TextSpan(
                  children: textQueries
                      .map((item) => TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (item is CSearchQueryLink) {
                                  handler.setSearchQuery(item.query);
                                  handler.closeDrawer(context);
                                } else if (item is CResultLink) {
                                  handler.goToResult(
                                    item.resultCategory,
                                    item.resultName,
                                  );
                                }
                              },
                            style: context.text.link,
                            text: item.label,
                          ))
                      .intersperse(const TextSpan(text: ", "))
                      .toList()),
            ),
          ),
        ],
      ),
      child: Text(
        "$label: ",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
