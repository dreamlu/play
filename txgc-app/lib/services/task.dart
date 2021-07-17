import 'request/index.dart';

final createTask = (data) => request('project/task/create', 'post', data: data);

final searchTask =
    (data) => request('project/task/search', 'get', parame: data);

final updateTask = (data) => request('project/task/update', 'put', data: data);

final removeTask = (id) => request(
      'project/task/delete/$id',
      'delete',
    );
