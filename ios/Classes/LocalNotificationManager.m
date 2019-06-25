//
//  LocalNotificationManager.m
//  local_notification
//
//  Created by 杨雪剑 on 2019/6/24.
//

#import "LocalNotificationManager.h"
#import <UserNotifications/UserNotifications.h>

@interface LocalNotificationManager ()

@end

@implementation LocalNotificationManager


+ (instancetype)share {
    static LocalNotificationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocalNotificationManager alloc] init];
    });
    
    return manager;
}

+ (instancetype)manager {
    
    return [[LocalNotificationManager alloc] init];
    
}

- (void)registerNotification:(id)delegate {
    
    
    UNUserNotificationCenter *center =  [UNUserNotificationCenter currentNotificationCenter];
    
    center.delegate = delegate;
    
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"获取通知");
    }];
    
}


- (void)createWithTitle:(NSString *)title
               subtitle:(NSString *)subtitle
                content:(NSString *)content
                weekDay:(NSInteger)weekDay
                    day:(NSInteger)day
                   hour:(NSInteger)hour
                minutes:(NSInteger)minute
                seconds:(NSInteger)seconds
              identfier:(NSString *)identfier
                 repeat:(BOOL)repeat
{
    
    UNMutableNotificationContent *notiContent = [self buildNotificationContent:title content:content];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
   
    [dateComponents setHour:hour];
    
    [dateComponents setMinute:minute];
    
   
    if (weekDay > 0) {
        [dateComponents setWeekday:weekDay];
    }

    if (day > 0) {
        [dateComponents setDay:day];
    }

    if (seconds) {
        [dateComponents setSecond:seconds];
    }
    
    [self trigger:notiContent identifier:identfier dateComponents:dateComponents repeat:repeat];
    
}

- (UNMutableNotificationContent *)buildNotificationContent:(NSString *)title content:(NSString *)content {
    
    UNMutableNotificationContent *notiContent = [[UNMutableNotificationContent alloc] init];
    
    notiContent.title = title;
    notiContent.body = content;
    
    return notiContent;
    
}

- (void)trigger:(UNMutableNotificationContent *)content identifier:(NSString *)id dateComponents:(NSDateComponents *)dateConponent repeat:(BOOL)repeat{
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateConponent repeats:repeat];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:id content:content trigger:trigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        NSLog(@"添加提醒：%@",error);
        
    }];
    
    NSLog(@"触发时间：%@",trigger.nextTriggerDate);
    
}

- (NSArray *)getAll {
    NSMutableArray *result = [NSMutableArray array];

    NSArray *notifications =   [UIApplication sharedApplication].scheduledLocalNotifications;

    for (UNNotification *notifi in notifications) {
        
        [result addObject:notifi.request.identifier];
        
    }
    
    return result;
}

- (void)remove:(NSString *)identifier {
    
  NSArray *notifications =   [UIApplication sharedApplication].scheduledLocalNotifications;
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (UNNotification *notifi in notifications) {
        
        if([notifi.request.identifier hasPrefix:identifier]) {
            
            [[UIApplication sharedApplication]cancelLocalNotification:notifi];
            
        }
        
    }
    
}



@end
