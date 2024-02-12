import 'package:graphql_flutter/graphql_flutter.dart';

class GraphService {
  final httpLink = HttpLink("https://graphql.anilist.co");

  GraphQLClient client() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
