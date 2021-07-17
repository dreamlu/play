import 'request/index.dart';

final createCar = (data) => request('project/car/create', 'post', data: data);

final searchCar =
    (data) => request('project/car/search', 'get', parame: data);

final updateCar = (data) => request('project/car/update', 'put', data: data);

final removeCar = (id) => request(
      'project/car/delete/$id',
      'delete',
    );
