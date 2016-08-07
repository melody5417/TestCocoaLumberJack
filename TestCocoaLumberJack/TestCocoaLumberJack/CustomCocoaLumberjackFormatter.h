//
//  CustomCocoaLumberjackFormatter.h
//  TestCocoaLumberJack
//
//  Created by Yiqi Wang on 8/7/16.
//  Copyright © 2016 Yiqi Wang. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface CustomCocoaLumberjackFormatter : NSObject <DDLogFormatter> {
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
