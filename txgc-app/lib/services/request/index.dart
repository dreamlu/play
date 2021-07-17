import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:txgc_app/constants/index.dart';
import 'package:txgc_app/model/pager.dart';
import 'package:txgc_app/utils/global.dart';
import 'package:txgc_app/utils/index.dart';
import './base_resp.dart';

/// 参考配置https://github.com/Sky24n/FlutterRepos/

final bool _isDebug = true;

final String _statusKey = "status";

final String _msgKey = "msg";

final String _dataKey = "data";

final String _dataPager = "pager";

final String _dataToken = "token";

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

///Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.status,
    this.code,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResp [String status]字段 key, 默认：status.
  String status;

  /// BaseResp [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResp [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResp [T data]字段 key, 默认：data.
  String data;

  /// Options.
  BaseOptions options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// print Http Log.
void _printHttpLog(Response response) {
  if (!_isDebug) {
    return;
  }
  try {
    print("----------------Http Log----------------" +
        "\n[statusCode]:   " +
        response.statusCode.toString() +
        "\n[request   ]:   " +
        _getOptionsStr(response.request));
    _printDataStr("reqdata ", response.request.data);
    _printDataStr("parame ", response.request.queryParameters);
    _printDataStr("response", response.data);
  } catch (ex) {
    print("Http Log" + " error......");
  }
}

/// print Data Str.
void _printDataStr(String tag, Object value) {
  String da = value.toString();
  while (da.isNotEmpty) {
    if (da.length > 512) {
      print("[$tag  ]:   " + da.substring(0, 512));
      da = da.substring(512, da.length);
    } else {
      print("[$tag  ]:   " + da);
      da = "";
    }
  }
}

/// get Options Str.
String _getOptionsStr(RequestOptions request) {
  return "method: " + request.method + "  baseUrl: " + request.uri.toString();
}

/// check Options.
RequestOptions _checkOptions(method, options) {
  if (options == null) {
    options = new RequestOptions();
  }
  options.method = method;
  options.baseUrl = API_PREFIX;

  options.headers['token'] = Global.userCache.user?.token;
  return options;
}

Map<String, dynamic> _decodeData(Response response) {
  if (response == null ||
      response.data == null ||
      response.data.toString().isEmpty) {
    return new Map();
  }
  return json.decode(response.data.toString());
}

/// 鉴定token是否失效
Interceptor authentication() {
  return InterceptorsWrapper(onRequest: (RequestOptions options) async {
    return options;
  }, onResponse: (Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      if (response.data[_statusKey] == 203 &&
          response.request.path != 'token') {
        // token失效
        getToken();
        return new DioError(
          response: response,
          error: "203",
          type: DioErrorType.RESPONSE,
        );
      }
    }
    return response; // continue
  }, onError: (DioError e) async {
    // Do something with response error
    return e; //continue
  });
}

Future<BaseResp<T>> request<T>(String path, String method,
    {data, parame, RequestOptions options, CancelToken cancelToken}) async {
  Dio dio = (new Dio());
  dio.interceptors.add(authentication());

  Response response = await dio.request(path,
        data: data,
        queryParameters: parame,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
  

  _printHttpLog(response);
  String _status;
  String _msg;
  Pager _pager;
  String _token;
  T _data;

  if (response.statusCode == HttpStatus.ok ||
      response.statusCode == HttpStatus.created) {
    try {
      if (response.data is Map) {
        _status = (response.data[_statusKey] is int)
            ? response.data[_statusKey].toString()
            : response.data[_statusKey];
        _msg =
            response.data[_msgKey] is String ? response.data[_msgKey] : '系统繁忙';
        _data = response.data[_dataKey];
        if (response.data[_dataPager] != null) {
          _pager = Pager.fromJson(response.data[_dataPager]);
        }

        if (response.data[_dataToken] != null) {
          _token = response.data[_dataToken];
        }

        if (_data == null) {
          _data = _pager != null ? [] : response.data;
        }
      } else {
        Map<String, dynamic> _dataMap = _decodeData(response);
        _status = (_dataMap[_statusKey] is int)
            ? _dataMap[_statusKey].toString()
            : _dataMap[_statusKey];
        _msg = _dataMap[_msgKey];
        _data = _dataMap[_dataKey];
      }
      return new BaseResp(_status, _msg, _data, pager: _pager, token: _token);
    } catch (e) {
      return new Future.error(new DioError(
        response: response,
        error: "data parsing exception...",
        type: DioErrorType.RESPONSE,
      ));
    }
  }
  return new Future.error(new DioError(
    response: response,
    error: "statusCode: $response.statusCode, service error",
    type: DioErrorType.RESPONSE,
  ));
}
