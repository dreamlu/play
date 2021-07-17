import 'package:txgc_app/constants/index.dart';

class Media {
  String rawUrl;
  String url;
  String name;

  Media({this.rawUrl, this.name});

  Media.fromJson(Map<String, dynamic> json) {
    rawUrl = json['rawUrl'];
    url = '$MEDIA_PREFIX$rawUrl';
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rawUrl'] = this.rawUrl;
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}
