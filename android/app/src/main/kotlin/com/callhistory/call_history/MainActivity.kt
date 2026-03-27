//package com.callhistory.call_history
package com.calhistory.calhistory

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "call_events"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {

                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    CallStreamHandler.eventSink = events
                }

                override fun onCancel(arguments: Any?) {
                    CallStreamHandler.eventSink = null
                }
            })
    }
}
