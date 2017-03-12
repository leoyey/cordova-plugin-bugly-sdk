package com.zhangpenglin.cordova.bugly;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import android.webkit.WebView;
import org.json.JSONArray;
import org.json.JSONException;

import android.app.Application;

import com.tencent.bugly.crashreport.CrashReport;

public class CDVBugly extends CordovaPlugin {

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        System.out.println("Bugly running.......");
        CrashReport.initCrashReport(this.cordova.getActivity().getApplicationContext());
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("test")) {
            String message = args.getString(0);
            this.test(message, callbackContext);
            return true;
        }
        return false;
    }

    private void test(String message, CallbackContext callbackContext) {

        this.cordova.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                throw new RuntimeException("This is a crash");
            }
        });
        callbackContext.success(message);
    }

}