import 'request/index.dart';

final createOrder =
    (data) => request('project/work/order/create', 'post', data: data);

final searchOrder =
    (data) => request('project/work/order/search', 'get', parame: data);

final updateOrder =
    (data) => request('project/work/order/update', 'put', data: data);

final removeOrder = (id) => request(
      'project/work/order/delete/$id',
      'delete',
    );
