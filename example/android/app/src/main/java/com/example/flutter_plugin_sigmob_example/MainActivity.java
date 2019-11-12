package com.example.flutter_plugin_sigmob_example;

import android.os.Bundle;

import com.example.flutter_plugin_sigmob.AdUtil;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    AdUtil.setContext(this);
    GeneratedPluginRegistrant.registerWith(this);
  }
}
