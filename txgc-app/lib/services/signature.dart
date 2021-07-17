import 'request/index.dart';

final createSignature =
    (data) => request('project/signature/create', 'post', data: data);

final searchSignature =
    (data) => request('project/signature/search', 'get', parame: data);

final updateSignature =
    (data) => request('project/signature/update', 'put', data: data);

final removeSignature = (id) => request(
      'project/signature/delete/$id',
      'delete',
    );
