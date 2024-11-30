package com.example.flutter_native_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.Date

class MainActivity : FlutterActivity() {
    @Override
    protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(getFlutterEngine().getDartExecutor(), CHANNEL).setMethodCallHandler(
            { call, result ->
                if (call.method.equals("getCurrentDate")) {
                    val currentDate: String = currentDate
                    result.success(currentDate)
                } else {
                    result.notImplemented()
                }
            }
        )
    }

    private val currentDate: String
        get() {
            val dateFormat: SimpleDateFormat = SimpleDateFormat("dd.MM.yyyy")
            val date: Date = Date()
            return dateFormat.format(date)
        }

    companion object {
        private val CHANNEL: String = "com.example.flutter_native_example/date"
    }
}