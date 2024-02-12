import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'country_model.dart';

class SearchCountryPage extends StatefulWidget {
  const SearchCountryPage({super.key});

  @override
  State<SearchCountryPage> createState() => _SearchCountryPageState();
}

class _SearchCountryPageState extends State<SearchCountryPage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(50,),
          TextField(
            onEditingComplete: () {
              setState(() {});
            },
            controller: controller,
          ),
          Query(
            builder: (result, {refetch, fetchMore}) {
              if (result.hasException) {
                return const Expanded(
                    child: Center(child: Text("Nimadir xato ketdi"),));
              }
              if (result.isLoading) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator(),));
              }
              final data = CountryClass.fromJson(result.data?["country"]??{});
              return Expanded(child: Text("$data"));
            },
            options: QueryOptions(document: gql("""
            query Query {
              country(code: "${controller.text}") {
                name
                native
                capital
                emoji
                currency
                 languages {
                    code
                    name
    }
  }
}
            """)),
          ),
        ],
      ),
    );
  }
}
