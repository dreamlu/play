import 'request/index.dart';

final searchEngine =
    (data) => request('engine/search', 'get', parame: data);
