
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class GraphicalLink {
  static HttpLink httpLink= HttpLink("https://apollohospitals.myshopify.com/api/2023-04/graphql.json",
    defaultHeaders: {
      'X-Shopify-Storefront-Access-Token': 'e44583241c0b66f362b767ec913c07e9',
    },

  );
  static Link link= httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
  ),
  );
}