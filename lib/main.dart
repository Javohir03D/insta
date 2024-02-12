import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'anime.dart';
import 'graphql_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = GraphService();
  runApp(
    MyApp(
      client: ValueNotifier(service.client()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final ValueNotifier<GraphQLClient>? client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimePage(),
      ),
    );
  }
}
