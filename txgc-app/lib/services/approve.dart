import 'request/index.dart';

final createApprove =
    (data) => request('project/approve/create', 'post', data: data);

final searchApprove =
    (data) => request('project/approve/search', 'get', parame: data);

final updateApprove =
    (data) => request('project/approve/update', 'put', data: data);

final removeApprove = (id) => request(
      'project/approve/delete/$id',
      'delete',
    );
