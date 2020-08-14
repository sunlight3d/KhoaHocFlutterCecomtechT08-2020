package com.example.myapp

import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(), MethodChannel.MethodCallHandler {
    private val CHANNEL = "cecomtech.training/printf";
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler(this)
    }

    private fun printf(name: String?, age: Int?, result: MethodChannel.Result){
        try {
            val toast = Toast.makeText(
                    applicationContext,
                    "Hello mr $name, age = ${age}", Toast.LENGTH_LONG)
            toast.show()
            result.success(null)
        } catch (e: Exception) {
            result.error("500", e.toString(), null)
        }
    }
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "printf") {
            val name: String? = call.argument("name")
            val age: Int? = call.argument("age")
            printf(name, age, result);
        } else {
            result.notImplemented()
        }
    }
}
