import 'package:flutter/services.dart';

abstract class SigmobEventHandler {
  final Function(SigmobEvents, Map<String, dynamic>) _listener;

  SigmobEventHandler(Function(SigmobEvents, Map<String, dynamic>) listener) : _listener = listener;

  Future<dynamic> handleEvent(MethodCall call) async {
    switch (call.method) {
      case 'didSuccess':
        _listener(SigmobEvents.didSuccess, null);
        break;
      case 'didFail':
        _listener(SigmobEvents.didFail, null);
        break;
      case 'loadSuccess':
        _listener(SigmobEvents.loadSuccess, null);
        break;
      case 'playStart':
        _listener(SigmobEvents.playStart, null);
        break;
      case 'playEnd':
        _listener(SigmobEvents.playEnd, null);
        break;
      case 'clicked':
        _listener(SigmobEvents.clicked, null);
        break;
      case 'didError':
        _listener(SigmobEvents.didError, null);
        break;
      case 'playError':
        _listener(SigmobEvents.playError, null);
        break;
      case 'closed':
        _listener(SigmobEvents.closed, null);
        break;
    }

    return null;
  }

}



enum SigmobEvents {
  didSuccess,  // 有广告返回
  didFail, // 无广告返回
  loadSuccess, // 广告加载成功
  playStart, // 广告开始播放
  playEnd, // 广告播放完毕
  clicked, // 广告发生点击
  didError, // 广告发生错误
  playError, // 播放时发生错误
  closed, // 广告播放完毕并点击了关闭按钮
}