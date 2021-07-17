import 'request/index.dart';

final createContract =
    (data) => request('project/contract/create', 'post', data: data);

final searchContract =
    (data) => request('project/contract/search', 'get', parame: data);

final removeContract = (id) => request(
      'project/contract/delete/$id',
      'delete',
    );
