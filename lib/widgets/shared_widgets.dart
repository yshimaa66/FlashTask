import 'package:fluttertoast/fluttertoast.dart';

showToast({required String msg, toastLength}) => Fluttertoast.showToast(
  msg: msg,
  //  toastDuration: Duration(seconds: 2),
  // toastLength: toastLength ?? Toast.LENGTH_LONG,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 10,
  // backgroundColor: Colors.red,
  // textColor: Colors.white,
  fontSize: 16.0,
);