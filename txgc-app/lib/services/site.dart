import 'request/index.dart';

final searchSite =
    (data) => request('construct/branch/site/search', 'get', parame: data);
