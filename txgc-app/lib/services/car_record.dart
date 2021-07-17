import 'request/index.dart';

final createCarRecord =
    (data) => request('project/car/record/create', 'post', data: data);

final searchCarRecord =
    (data) => request('project/car/record/search', 'get', parame: data);

final updateCarRecord =
    (data) => request('project/car/record/update', 'put', data: data);

final removeCarRecord = (id) => request(
      'project/car/record/delete/$id',
      'delete',
    );
