import 'dart:convert' show json;

class Change {
  int code;
  bool success;
  String massege;

  Change.fromParams({this.code, this.success, this.massege});

  factory Change(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Change.fromJson(json.decode(jsonStr))
          : new Change.fromJson(jsonStr);

  Change.fromJson(jsonRes) {
    code = jsonRes['code'];
    success = jsonRes['success'];
    massege = jsonRes['massege'];
  }

  @override
  String toString() {
    return '{"code": $code,"success": $success,"massege": ${massege != null ? '${json.encode(massege)}' : 'null'}}';
  }
}
