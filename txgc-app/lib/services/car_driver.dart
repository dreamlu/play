import 'request/index.dart';

final createCarDriver =
    (data) => request('project/car/driver/create', 'post', data: data);

final searchCarDriver =
    (data) => request('project/car/driver/search', 'get', parame: data);

final updateCarDriver =
    (data) => request('project/car/driver/update', 'put', data: data);

final removeCarDriver = (id) => request(
      'project/car/driver/delete/$id',
      'delete',
    );
