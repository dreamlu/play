import 'request/index.dart';

final createShareEdit =
    (data) => request('project/share_edit/create', 'post', data: data);

final searchShareEdit =
    (data) => request('project/share_edit/search', 'get', parame: data);

final updateShareEdit =
    (data) => request('project/share_edit/update', 'put', data: data);

final removeShareEdit = (id) => request(
      'project/share_edit/delete/$id',
      'delete',
    );
