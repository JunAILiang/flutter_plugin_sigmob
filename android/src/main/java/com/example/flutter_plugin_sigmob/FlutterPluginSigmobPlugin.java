package com.example.flutter_plugin_sigmob;

import java.util.ArrayList;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginSigmobPlugin */
public class FlutterPluginSigmobPlugin implements MethodCallHandler {

  public static MethodChannel channel;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    channel = new MethodChannel(registrar.messenger(), "flutter_plugin_sigmob");
    channel.setMethodCallHandler(new FlutterPluginSigmobPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("init")) {
      ArrayList<String> args = (ArrayList<String>) call.arguments;
      AdUtil.init(args.get(0), args.get(1));
    } else if (call.method.equals("loadVideo")) {
      AdUtil.loadVideo((String) call.arguments);
    } else if (call.method.equals("showVideo")) {
      AdUtil.showVideo((String) call.arguments);
    } else {
      result.notImplemented();
    }
  }
}
