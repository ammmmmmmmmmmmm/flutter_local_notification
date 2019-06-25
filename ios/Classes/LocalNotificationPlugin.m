#import "LocalNotificationPlugin.h"
#import "LocalNotificationManager.h"
@interface LocalNotificationPlugin ()

@end

@implementation LocalNotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"local_notification"
            binaryMessenger:[registrar messenger]];
  LocalNotificationPlugin* instance = [[LocalNotificationPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {

    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);

  } else if([@"add" isEqualToString:call.method]){

            NSDictionary *args = call.arguments;
            int x = [[args valueForKey:@"x"] intValue];
            int y = [[args valueForKey:@"y"] intValue];
            NSNumber *sum = [NSNumber numberWithLong:(x+y)];
            result(sum);

  } else if([@"create" isEqualToString:call.method]) {
    
      NSDictionary *args = call.arguments;
      NSString *identfier = [args valueForKey:@"id"];
      NSString *title = [args valueForKey:@"title"];
      NSString *content = [args valueForKey:@"content"];
      NSString *subtitle = [args valueForKey:@"subtitle"];
      NSString *weekDay = [args valueForKey:@"weekDay"];
      NSString *day = [args valueForKey:@"day"];
      NSString *hour = [args valueForKey:@"hour"];
      NSString *minute = [args valueForKey:@"minutes"];
      NSString *repeat = [args valueForKey:@"repeat"];
      NSString *second = [args valueForKey:@"second"];
      
    LocalNotificationManager *manager =  [LocalNotificationManager share];
      [manager createWithTitle:title subtitle:subtitle content:content weekDay:weekDay.integerValue day:day.integerValue hour:hour.integerValue minutes:minute.integerValue seconds:second.integerValue identfier:identfier repeat:repeat.boolValue];
      
      NSLog(@"%@",args);
      
  } else if([@"all" isEqualToString:call.method]) {
      
      NSArray *array = [[LocalNotificationManager share] getAll];
      result(array);
      
  } else if([@"remove" isEqualToString:call.method]) {
      
      NSString *identfier = [call.arguments valueForKey:@"identifier"];
      
      [[LocalNotificationManager share] remove:identfier];
      
  }
  else {

    result(FlutterMethodNotImplemented);

  }

}

@end
