import 'request/index.dart';

final createFileReceive =
    (data) => request('project/file_receive/create', 'post', data: data);

final searchFileReceive =
    (data) => request('project/file_receive/search', 'get', parame: data);

final updateFileReceive =
    (data) => request('project/file_receive/update', 'put', data: data);

final removeFileReceive = (id) => request(
      'project/file_receive/delete/$id',
      'delete',
    );
