import 'package:graphql/client.dart';

import '../../config/app_key.dart';
import '../../config/backend.dart';
import '../spref.dart';

final HttpLink _httpLink = HttpLink(BackendHost.BACKEND_HTTP);

final AuthLink _authLink = AuthLink(
    getToken: () async {
      final token = await SPref.instance.get(AppKey.xToken);
      // print("x-token api- $token");
      return token;
    },
    headerKey: BACKEND_TOKEN_HEADER);

final Link _link = _authLink.concat(_httpLink);
final _wsLink = WebSocketLink(BackendHost.BACKEND_WSS);

final GraphQLClient graphqlClient = GraphQLClient(
  cache: GraphQLCache(),
  link: Link.split((request) => request.isSubscription, _wsLink, _link),
);
