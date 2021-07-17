import 'request/index.dart';

final queryPerson =
    (data) => request('project/person/list', 'get', parame: data);
