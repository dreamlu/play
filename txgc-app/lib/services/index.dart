import 'package:txgc_app/services/request/index.dart';

final userLogin = (data) => request('login', 'post', data: data);

final queryToken = (parame) => request('token', 'get', parame: parame);

final uploadFile = (data) => request(
      'file/multi_upload',
      'post',
      data: data,
    );

final pdfSign = (data) => request('engine/office/pdf/sign', 'post', data: data);

final createNotify = (data) => request('notify/create', 'post', data: data);

final queryProjectList =
    (parame) => request('project/list', 'get', parame: parame);
