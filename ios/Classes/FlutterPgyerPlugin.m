#import "FlutterPgyerPlugin.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

static NSString *kPgyerSetApiMethod = @"flutter_pgyer/sdk/setApiKey";
static NSString *kPgyerCheckUpdateMethod = @"flutter_pgyer/sdk/checkUpdate";
static NSString *kPgyerReportExceptionMethod = @"flutter_pgyer/sdk/reportException";

@implementation FlutterPgyerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_pgyer"
            binaryMessenger:[registrar messenger]];
  FlutterPgyerPlugin* instance = [[FlutterPgyerPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  // 配置ak，初始化sdk
  if ([kPgyerSetApiMethod isEqualToString:call.method]) {
    NSDictionary *dic = (NSDictionary *)call.arguments;
    NSString *AK = dic[@"appKey"];
    if (!AK) {
      NSLog(@"请填写正确的appKey");
      return;
    }
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:AK];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:AK];

    // 设置用户反馈界面激活方式为摇一摇
    [[PgyManager sharedPgyManager] setFeedbackActiveType:kPGYFeedbackActiveTypeShake];
    [[PgyManager sharedPgyManager] setShakingThreshold:3.0];
    NSLog(@"ios-PgyManager、PgyUpdateManager启动成功");
  } else if ([kPgyerReportExceptionMethod isEqualToString:call.method]) {
    NSDictionary *dic = (NSDictionary *)call.arguments;
    NSString *name = dic[@"exceptionName"];
    NSString *reason = dic[@"exceptionReason"];
    NSDictionary *userInfo = (NSDictionary *)dic[@"userInfo"];
    if (!name) {
      NSLog(@"请填写正确的exception name");
      return;
    }
    NSException *exception = [NSException exceptionWithName: name reason: reason userInfo: userInfo];

    [[PgyManager sharedPgyManager] reportException:exception];
  } else if ([kPgyerCheckUpdateMethod isEqualToString:call.method]) {
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
  } else if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
