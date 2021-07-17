import 'request/index.dart';

final createNotify = (data) => request('notify/create', 'post', data: data);

final searchNotify = (data) => request('notify/search', 'get', parame: data);
