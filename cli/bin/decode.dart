import 'package:cli/read_json.dart';

void main(List<String> arguments) async {
  final decoded = await readJson();
  print('JSON successfully decoded.');
  print(decoded);
}
