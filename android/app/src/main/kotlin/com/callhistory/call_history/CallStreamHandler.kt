package com.calhistory.calhistory

import io.flutter.plugin.common.EventChannel

object CallStreamHandler {
    var eventSink: EventChannel.EventSink? = null

    fun sendEvent(data: String) {
        eventSink?.success(data)
    }
}