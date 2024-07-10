
const String priceSort = '''
  query Price(\$handle: String!, \$reverse: Boolean, \$first: Int, \$after: String) {
            collection(handle: \$handle) {
              id
              handle
              products(first: \$first, sortKey: PRICE, reverse: \$reverse, after: \$after) {
                pageInfo {
                  hasNextPage
                  endCursor
                }
                edges {
                  node {
                    id
                    handle
                  }
                }
              }
            }
          }
''';