
#import <Cordova/CDVViewController.h>
#import <Bugly/Bugly.h>
#import "CDVBugly.h"

@implementation CDVBugly

- (void)pluginInitialize
{
    BuglyConfig * config = [[BuglyConfig alloc] init];

    config.reportLogLevel = BuglyLogLevelWarn;
    NSDictionary * dict = [[NSBundle mainBundle] infoDictionary];
    NSString * appid = [dict objectForKey:@"BuglyAppIDString"];
    [Bugly startWithAppId:appid config:config];

}

- (void)test:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    // [self testNSException];
    [self testSignalException];
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)testNSException {
    NSLog(@"it will throw an NSException ");
    NSArray * array = @[];
    NSLog(@"the element is %@", array[1]);
}

- (void)testSignalException {
    NSLog(@"test signal exception");
    int length = 1;
    NSLog(@"length=%@", length);
    NSString * null = nil;
    NSLog(@"print the nil string %s", [null UTF8String]);
}

- (void)testLogOnBackground {
    int cnt = 0;
    while (1) {
        cnt++;

        switch (cnt % 5) {
            case 0:
                BLYLogError(@"Test Log Print %d", cnt);
                break;
            case 4:
                BLYLogWarn(@"Test Log Print %d", cnt);
                break;
            case 3:
                BLYLogInfo(@"Test Log Print %d", cnt);
                BLYLogv(BuglyLogLevelWarn, @"BLLogv: Test", NULL);
                break;
            case 2:
                BLYLogDebug(@"Test Log Print %d", cnt);
                BLYLog(BuglyLogLevelError, @"BLLog : %@", @"Test BLLog");
                break;
            case 1:
            default:
                BLYLogVerbose(@"Test Log Print %d", cnt);
                break;
        }

        // print log interval 1 sec.
        sleep(1);
    }
}

@end
