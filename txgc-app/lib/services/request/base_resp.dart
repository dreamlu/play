import 'package:txgc_app/model/pager.dart';

/// <BaseResp<T> 返回 status msg data.
class BaseResp<T> {
  String status;
  String msg;
  Pager pager;
  String token;
  T data;

  BaseResp(this.status, this.msg, this.data, {this.pager, this.token});

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"status\":\"$status\"");
    sb.write(",\"msg\":\"$msg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write(",\"pager\":\"$pager\"");
    sb.write(",\"token\":\"$token\"");
    sb.write('}');
    return sb.toString();
  }
}
