import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_sigmob/sigmob_event_handler.dart';
export 'package:flutter_plugin_sigmob/sigmob_event_handler.dart';

class FlutterPluginSigmob extends SigmobEventHandler {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_sigmob');

  final void Function(SigmobEvents, Map<String, dynamic>) listener;

  FlutterPluginSigmob({
    this.listener
  }): super(listener) {
    if (listener != null) {
      _channel.setMethodCallHandler(handleEvent);
    }
  }

  /// 初始化
  static Future<void> init(String appId, String apiKey) async {
    _channel.invokeMethod("init", [appId, apiKey]);
  }

  /// 视频广告是否加载完成
  Future<bool> isReady(String placementId) async {
    return await _channel.invokeMethod('isReady');
  }

  /// 加载视频广告
  Future<void> loadVideo(String placementId) async {
    _channel.invokeMethod('loadVideo', placementId);
  }

  /// 播放视频广告
  Future<void> showVideo(String placementId) async {
    _channel.invokeMethod('showVideo', placementId);
  }


  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
