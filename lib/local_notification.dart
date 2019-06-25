import 'dart:async';

import 'package:flutter/services.dart';

class LocalNotification {
  static const MethodChannel _channel =
      const MethodChannel('local_notification');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<int> requestNativeAdd(int x,int y) async{
    
    int result = await _channel.invokeMethod("add",{"x":x,"y":y});

    return result;
  }

  static Future<void>create({
    String identifier,
    String title = "",
    String subtitle = "",
    String content = "",
    int    day = 0,
    int    month = 0,
    int    weekDay = 0,
    int    hour = 0,
    int    minutes = 0,
    int second = 0,
    bool   repeat = true
  }) async {

    await _channel.invokeMethod("create",
        {"hour":hour,
          "minutes":minutes,
          "second":second,
          "day":day,
          "weekday":weekDay,
          "month":month,
          "id":identifier,
          "title":title,
          "repeat":repeat,
          "subtitle":subtitle,
          "content":content
        });

  }

  static Future<List> all() async{

    final  List notifications = await  _channel.invokeMethod("all");

  return notifications;

  }

  static Future remove(String identifier) async {

    await _channel.invokeMethod("remove",{"identifier":identifier});

  }

}
