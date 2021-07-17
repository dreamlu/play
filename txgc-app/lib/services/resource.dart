import 'request/index.dart';

final createResource =
    (data) => request('project/resource/create', 'post', data: data);

final searchResource =
    (data) => request('project/resource/search', 'get', parame: data);

final updateResource =
    (data) => request('project/resource/update', 'put', data: data);

final removeResource = (id) => request(
      'project/resource/delete/$id',
      'delete',
    );
