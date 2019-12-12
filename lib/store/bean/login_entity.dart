import 'dart:convert' show json;

class Login {
  int code;
  bool success;
  String massege;
  Datas datas;

  Login.fromParams({this.code, this.success, this.massege, this.datas});

  factory Login(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Login.fromJson(json.decode(jsonStr))
          : new Login.fromJson(jsonStr);

  Login.fromJson(jsonRes) {
    code = jsonRes['code'];
    success = jsonRes['success'];
    massege = jsonRes['massege'];
    datas =
        jsonRes['datas'] == null ? null : new Datas.fromJson(jsonRes['datas']);
  }

  @override
  String toString() {
    return '{"code": $code,"success": $success,"massege": ${massege != null ? '${json.encode(massege)}' : 'null'},"datas": $datas}';
  }
}

class Datas {
  String id;
  String name;
  String phone;

  Datas.fromParams({this.id, this.name, this.phone});

  Datas.fromJson(jsonRes) {
    id = jsonRes['id'];
    name = jsonRes['name'];
    phone = jsonRes['phone'];
  }

  @override
  String toString() {
    return '{"id": ${id != null ? '${json.encode(id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"phone": ${phone != null ? '${json.encode(phone)}' : 'null'}}';
  }
}
