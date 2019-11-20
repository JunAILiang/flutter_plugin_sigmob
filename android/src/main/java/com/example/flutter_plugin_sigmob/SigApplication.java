package com.example.flutter_plugin_sigmob;

import android.content.Context;

import com.bun.miitmdid.core.JLibrary;

//用于支持获取oaid
public class SigApplication extends io.flutter.app.FlutterApplication {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        JLibrary.InitEntry(base);
    }
}
