import 'dart:io';

Future<bool> checkInternet() async {
  late bool res;
  try {
    List<InternetAddress> ping = await InternetAddress.lookup('www.google.com');
    if (ping.isNotEmpty && ping[0].rawAddress.isNotEmpty) {
      res = true;
    }
  } on SocketException catch (_) {
    res = false;
  }
  return res;
}
