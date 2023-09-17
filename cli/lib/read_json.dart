import 'dart:convert';

import 'package:cli/json_types.dart';
import 'dart:io';

import 'package:path/path.dart';

Future<CJsonRoot> readJson() async {
  final jsonFile = File(join("..", "CSRD.json"));
  final jsonString = await jsonFile.readAsString();
  return CJsonRoot.fromJson(jsonDecode(jsonString));
}
