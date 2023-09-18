import 'package:app/json_data/read_json.dart';

void main(List<String> arguments) async {
  final decoded = await readJson();
  print('JSON successfully decoded.');
  print(decoded);
}
