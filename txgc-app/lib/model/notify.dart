class Notify {
  String id;
  String createTime;
  String typ;
  String isDo;
  int kind;
  int nid;
  String from;
  int toId;
  String desc;

  Notify(
      {this.id,
        this.createTime,
        this.typ,
        this.isDo,
        this.kind,
        this.nid,
        this.from,
        this.toId,
        this.desc});

  Notify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['create_time'];
    typ = json['typ'];
    isDo = json['is_do'];
    kind = json['kind'];
    nid = json['nid'];
    from = json['from'];
    toId = json['to_id'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['create_time'] = this.createTime;
    data['typ'] = this.typ;
    data['is_do'] = this.isDo;
    data['kind'] = this.kind;
    data['nid'] = this.nid;
    data['from'] = this.from;
    data['to_id'] = this.toId;
    data['desc'] = this.desc;
    return data;
  }
}
