//
//  ViewController.m
//  TestCocoaLumberJack
//
//  Created by Yiqi Wang on 8/7/16.
//  Copyright © 2016 Yiqi Wang. All rights reserved.
//

#import "ViewController.h"
#import "CustomLogger.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)printLog:(id)sender {
    DDLogError(@"Meet George Jetson");
    DDLogWarn(@"Meet George Jetson");
    DDLogInfo(@"Meet George Jetson");
    DDLogDebug(@"Meet George Jetson");
    DDLogVerbose(@"Meet George Jetson");
}

@end
