//
//  CustomLogger.h
//  TestCocoaLumberJack
//
//  Created by Yiqi Wang on 8/7/16.
//  Copyright © 2016 Yiqi Wang. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

#ifndef CustomLogger_h
#define CustomLogger_h

#ifdef __cplusplus
extern "C" {
#endif
    
#ifdef DEBUG
#ifdef LOG_ASYNC_ENABLED
#undef LOG_ASYNC_ENABLED
#define LOG_ASYNC_ENABLED NO
#endif // LOG_ASYNC_ENABLED
#endif // DEBUG
    
#ifdef DEBUG
#define LOG_LEVEL_GLOBAL DDLogLevelAll
#else
#define LOG_LEVEL_GLOBAL DDLogLevelOff
#endif
    
    extern DDLogLevel ddLogLevel;
    void __NO_NSLog__(NSString *format, ...);
    
// 把NSLog定义掉
#ifdef DEBUG
#define NSLog(__FORMAT__, ...) DDLogDebug(__FORMAT__, ##__VA_ARGS__)
#else
#define NSLog(__FORMAT__, ...) __NO_NSLog__(__FORMAT__, ##__VA_ARGS__)
#endif
@interface CustomLogger : DDLog <DDRegisteredDynamicLogging>

@property(nonatomic, readonly, retain) DDFileLogger *fileLogger;

+ (instancetype)sharedInstance;

@end
    
#ifdef __cplusplus
}
#endif // __cplusplus

#endif /* CustomLogger_h */
