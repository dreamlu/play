import 'request/index.dart';

final createCsExample =
    (data) => request('project/cs_example/create', 'post', data: data);

final searchCsExample =
    (data) => request('project/cs_example/search', 'get', parame: data);

final removeCsExample = (id) => request(
      'project/cs_example/delete/$id',
      'delete',
    );
