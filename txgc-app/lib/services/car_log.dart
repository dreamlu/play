import 'request/index.dart';

final searchCarLog =
    (data) => request('project/car/log/search', 'get', parame: data);
