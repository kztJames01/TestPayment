

import 'package:flutter/cupertino.dart';

class HttpException implements Exception {
  String string = '';
  HttpException(this.string);
  @override
  String toString() {
    // TODO: implement toString
    return string;
  }
}
