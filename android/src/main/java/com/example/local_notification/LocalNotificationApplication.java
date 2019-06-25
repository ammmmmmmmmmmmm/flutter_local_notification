package com.example.local_notification;

import android.app.Application;
import android.content.Context;

public class LocalNotificationApplication extends Application {

    public   static Context context;

    @Override
    public void onCreate() {
        super.onCreate();
        context = this.getApplicationContext();

    }
}
