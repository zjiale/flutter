import 'dart:convert' show json;

class Order {
  int code;
  bool success;
  String massege;
  List<Datas> datas;

  Order.fromParams({this.code, this.success, this.massege, this.datas});

  factory Order(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new Order.fromJson(json.decode(jsonStr))
          : new Order.fromJson(jsonStr);

  Order.fromJson(jsonRes) {
    code = jsonRes['code'];
    success = jsonRes['success'];
    massege = jsonRes['massege'];
    datas = jsonRes['datas'] == null ? null : [];

    for (var datasItem in datas == null ? [] : jsonRes['datas']) {
      datas.add(datasItem == null ? null : new Datas.fromJson(datasItem));
    }
  }

  @override
  String toString() {
    return '{"code": $code,"success": $success,"massege": ${massege != null ? '${json.encode(massege)}' : 'null'},"datas": $datas}';
  }
}

class Datas {
  int region;
  String address;
  String appUserId;
  String createTime;
  String faulttype;
  String isOk;
  String msg;
  String msgId;
  String name;
  String orderId;
  String phone;
  String type;

  Datas.fromParams(
      {this.region,
      this.address,
      this.appUserId,
      this.createTime,
      this.faulttype,
      this.isOk,
      this.msg,
      this.msgId,
      this.name,
      this.orderId,
      this.phone,
      this.type});

  Datas.fromJson(jsonRes) {
    region = jsonRes['region'];
    address = jsonRes['address'];
    appUserId = jsonRes['appUserId'];
    createTime = jsonRes['createTime'];
    faulttype = jsonRes['faulttype'];
    isOk = jsonRes['isOk'];
    msg = jsonRes['msg'];
    msgId = jsonRes['msgId'];
    name = jsonRes['name'];
    orderId = jsonRes['orderId'];
    phone = jsonRes['phone'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"region": $region,"address": ${address != null ? '${json.encode(address)}' : 'null'},"appUserId": ${appUserId != null ? '${json.encode(appUserId)}' : 'null'},"createTime": ${createTime != null ? '${json.encode(createTime)}' : 'null'},"faulttype": ${faulttype != null ? '${json.encode(faulttype)}' : 'null'},"isOk": ${isOk != null ? '${json.encode(isOk)}' : 'null'},"msg": ${msg != null ? '${json.encode(msg)}' : 'null'},"msgId": ${msgId != null ? '${json.encode(msgId)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"orderId": ${orderId != null ? '${json.encode(orderId)}' : 'null'},"phone": ${phone != null ? '${json.encode(phone)}' : 'null'},"type": ${type != null ? '${json.encode(type)}' : 'null'}}';
  }
}
