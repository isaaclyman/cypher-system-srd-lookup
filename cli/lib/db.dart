import 'dart:io';

import 'package:cli/json_types.dart';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';

final _databasePath = join("..", "CSRD.db");
final _classesToCreateTablesFor = <Type>[
  CJsonAbility,
];

Future<void> deleteDatabase() async {
  try {
    await File(_databasePath).delete();
  } catch (ex) {
    print("Could not delete database.");
    print(ex);
  }
}

Future<void> createDatabase() async {
  final database = sqlite3.open(_databasePath);
}
