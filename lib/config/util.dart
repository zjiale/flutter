import 'package:dio/dio.dart';

Future request(url, {params, method, contentType}) async {
  try {
    Response response;
    Dio dio = new Dio();
    Options options = new Options(
        method: method ?? 'post',
        contentType: contentType ?? "application/x-www-form-urlencoded");
    response = await dio.request(url, data: params ?? {}, options: options);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return print('ERROR:======>${e}');
  }
}
