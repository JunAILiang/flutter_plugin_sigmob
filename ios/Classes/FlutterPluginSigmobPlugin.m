#import "FlutterPluginSigmobPlugin.h"
#import <WindSDK.h>

@interface FlutterPluginSigmobPlugin()<WindRewardedVideoAdDelegate>

/** channel **/
@property (nonatomic, strong) FlutterMethodChannel *channel;

@end

static FlutterPluginSigmobPlugin *instance = nil;
@implementation FlutterPluginSigmobPlugin

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedInstance {
    if (instance == nil) {
        instance = [[super alloc] init];
    }
    return instance;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [FlutterPluginSigmobPlugin sharedInstance].channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_plugin_sigmob"
            binaryMessenger:[registrar messenger]];
  FlutterPluginSigmobPlugin* instance = [[FlutterPluginSigmobPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:[FlutterPluginSigmobPlugin sharedInstance].channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]) {
      NSString *appId = [call.arguments firstObject];
      NSString *apiKey = [call.arguments lastObject];
      WindAdOptions *options = [WindAdOptions options];
      options.appId = appId;
      options.apiKey = apiKey;
      [WindAds startWithOptions:options];
  } else if ([@"loadVideo" isEqualToString:call.method]) {
      NSLog(@"loadVideo");
      WindAdRequest *request = [[WindAdRequest alloc] init];
      request.placementId = call.arguments;
      request.needReward = YES;
      [WindRewardedVideoAd sharedInstance].delegate = self;
      [[WindRewardedVideoAd sharedInstance] loadRequest:request withPlacementId:call.arguments];
  } else if ([@"showVideo" isEqualToString:call.method]) {
      NSLog(@"showVideo");
      BOOL isReady = [[WindRewardedVideoAd sharedInstance] isReady:call.arguments];
      if (isReady) {
          [[WindRewardedVideoAd sharedInstance] playAd:[UIApplication sharedApplication].keyWindow.rootViewController withPlacementId:call.arguments options:nil error:nil];
      }
  } else if ([@"isReady" isEqualToString:call.method]) {
      BOOL isReady = [[WindRewardedVideoAd sharedInstance] isReady:call.arguments];
      result(@(isReady));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - WindRewardedVideoAdDelegate
// 加载成功
- (void)onVideoAdLoadSuccess:(NSString *)placementId {
    [self.channel invokeMethod:@"loadSuccess" arguments:nil];
}

// 开始播放
- (void)onVideoAdPlayStart:(NSString *)placementId {
    [self.channel invokeMethod:@"playStart" arguments:nil];
}

// 点击
- (void)onVideoAdClicked:(NSString *)placementId {
    [self.channel invokeMethod:@"clicked" arguments:nil];
}

// 完成(奖励)广告关闭
- (void)onVideoAdClosedWithInfo:(WindRewardInfo *)info placementId:(NSString *)placementId {
    [self.channel invokeMethod:@"closed" arguments:nil];
}

// 错误
- (void)onVideoError:(NSError *)error placementId:(NSString *)placementId {
    [self.channel invokeMethod:@"didError" arguments:nil];
}

// 播放出错
- (void)onVideoAdPlayError:(NSError *)error placementId:(NSString *)placementId {
    [self.channel invokeMethod:@"playError" arguments:nil];
}

// 播放完毕
- (void)onVideoAdPlayEnd:(NSString *)placementId {
    [self.channel invokeMethod:@"playEnd" arguments:nil];
}

// 返回广告
- (void)onVideoAdServerDidSuccess:(NSString *)placementId {
    [self.channel invokeMethod:@"didSuccess" arguments:nil];
}

// 无广告返回
- (void)onVideoAdServerDidFail:(NSString *)placementId {
    [self.channel invokeMethod:@"didFail" arguments:nil];
}

@end
