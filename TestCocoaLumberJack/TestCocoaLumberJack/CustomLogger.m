//
//  CustomLogger.m
//  TestCocoaLumberJack
//
//  Created by Yiqi Wang on 8/7/16.
//  Copyright © 2016 Yiqi Wang. All rights reserved.
//

#import "CustomLogger.h"
#import "CustomCocoaLumberjackFormatter.h"

DDLogLevel ddLogLevel = LOG_LEVEL_GLOBAL;

void __NO_NSLog__(NSString *format, ...) {}

@interface CustomLogger ()
@property(nonatomic, readwrite, retain) DDFileLogger *fileLogger;
@end

@implementation CustomLogger

+ (instancetype)sharedInstance {
    static CustomLogger *ret = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ret = [[[self class] alloc] init];
    });
    
    return ret;
}

+ (void)load {
    [super load];
    
    [self setupXcodeColorsEnv];
    [[self sharedInstance] configureLoggers];
}

+ (DDLogLevel)ddLogLevel {
    return ddLogLevel;
}

+ (void)ddSetLogLevel:(DDLogLevel)level {
    ddLogLevel = level;
}

+ (void)setupXcodeColorsEnv {
    char *xcode_colors = getenv("XcodeColors");
    
    BOOL isaXcodeColorTTY = YES;
    if (!xcode_colors || (strcmp(xcode_colors, "YES") != 0)) {
        isaXcodeColorTTY = NO;
    }
    if (!isaXcodeColorTTY) {
        setenv("XcodeColors", "YES", 0);
    }
}

- (void)configureLoggers {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* DDFileLogger */
        NSArray *libPathList = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libPath = [libPathList objectAtIndex:0];
        NSString *logPath = [libPath stringByAppendingPathComponent:@"Logs"];
        DDLogFileManagerDefault *defaultLogFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logPath];
        DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:defaultLogFileManager];
        fileLogger.rollingFrequency = kDDDefaultLogRollingFrequency;
        fileLogger.maximumFileSize = kDDDefaultLogMaxFileSize;
        fileLogger.logFileManager.maximumNumberOfLogFiles = kDDDefaultLogMaxNumLogFiles;
        self.fileLogger = fileLogger;
        
        CustomCocoaLumberjackFormatter *logFormatter = [[CustomCocoaLumberjackFormatter alloc] init];
        [self.fileLogger setLogFormatter:logFormatter];
        [DDLog addLogger:self.fileLogger];
        
        
        /* DDTTYLogger */
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        
        #if DEBUG
        DDColor *errColor = DDMakeColor(255.0, 44.0, 56.0);
        DDColor *warColor = DDMakeColor(188.0, 124.0, 72.0);
        DDColor *infColor = DDMakeColor(65.0, 204.0, 69.0);
        DDColor *dbgColor = DDMakeColor(102.0, 102.0, 102.0);
        DDColor *verColor = DDMakeColor(204.0, 204.0, 204.0);
        
        [[DDTTYLogger sharedInstance] setForegroundColor:errColor backgroundColor:nil forFlag:DDLogFlagError];
        [[DDTTYLogger sharedInstance] setForegroundColor:warColor backgroundColor:nil forFlag:DDLogFlagWarning];
        [[DDTTYLogger sharedInstance] setForegroundColor:infColor backgroundColor:nil forFlag:DDLogFlagInfo];
        [[DDTTYLogger sharedInstance] setForegroundColor:dbgColor backgroundColor:nil forFlag:DDLogFlagDebug];
        [[DDTTYLogger sharedInstance] setForegroundColor:verColor backgroundColor:nil forFlag:DDLogFlagVerbose];
        #endif
        
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
    });
}

@end
