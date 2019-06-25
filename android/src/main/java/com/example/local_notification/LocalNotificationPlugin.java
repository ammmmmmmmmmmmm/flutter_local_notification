package com.example.local_notification;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;


/** LocalNotificationPlugin */
public class LocalNotificationPlugin implements MethodCallHandler {

  private static BasicMessageChannel<Object> runTimeSender;

  public static Context context;

  private static int icon;
  private  static  int bigmap;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar,int icon,int bigmap) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "local_notification");
    channel.setMethodCallHandler(new LocalNotificationPlugin());

    runTimeSender = new BasicMessageChannel<Object>(registrar.messenger(),"run_time",new StandardMessageCodec());

     context = registrar.activeContext();

     icon = icon;
     bigmap = bigmap;

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if("create".equals(call.method)) {

      NotificationUtils.share().notification(null,context,icon,bigmap);
    }else if("all".equals(call.method)) {

    }else if("remive".equals(call.method)) {

    }
    else {
      result.notImplemented();
    }
  }
}
