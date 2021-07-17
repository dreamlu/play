import 'request/index.dart';

final createMeeting =
    (data) => request('project/meeting/create', 'post', data: data);

final searchMeeting =
    (data) => request('project/meeting/search', 'get', parame: data);

final updateMeeting =
    (data) => request('project/meeting/update', 'put', data: data);

final removeMeeting = (id) => request(
      'project/meeting/delete/$id',
      'delete',
    );
