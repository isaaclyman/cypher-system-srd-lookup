import 'package:cypher_system_srd_lookup/json_data/read_json.dart';
import 'package:cypher_system_srd_lookup/navigation/nav_config.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readSrdJson(),
        builder: (context, snapshot) {
          Widget child = const Center(
            child: CircularProgressIndicator(),
          );

          if (snapshot.hasError) {
            child = const Center(
              child: Text("Erorr loading data file."),
            );
          } else if (snapshot.hasData) {
            child = MaterialApp.router(
              routerConfig: CRouterConfig(dataRoot: snapshot.data!).config,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(useMaterial3: true),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            child = const Center(
              child: Text("Data file is empty."),
            );
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: child,
          );
        });
  }
}
