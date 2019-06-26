//
//  LocalNotificationManager.h
//  local_notification
//
//  Created by 杨雪剑 on 2019/6/24.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LocalNotificationManager : NSObject

+ (instancetype)share;
+ (instancetype)manager;
- (void)registerNotification:(id)delegate;
- (void)createWithTitle:(NSString *)title
               subtitle:(NSString *)subtitle
                content:(NSString *)content
                weekDay:(NSInteger)weekDay
                    day:(NSInteger)day
                   hour:(NSInteger)hour
                minutes:(NSInteger)minute
                seconds:(NSInteger)seconds
              identfier:(NSString *)identfier
                 repeat:(BOOL)repeat;

- (NSArray *)getAll;
- (void)remove:(NSString *)identifier;
-(void)setBadge:(NSInteger)badge;

@end

NS_ASSUME_NONNULL_END
