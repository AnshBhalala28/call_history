package com.calhistory.calhistory

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.telephony.TelephonyManager

class CallReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {

        val state = intent.getStringExtra(TelephonyManager.EXTRA_STATE)
        val number = intent.getStringExtra(TelephonyManager.EXTRA_INCOMING_NUMBER)

        when (state) {
            TelephonyManager.EXTRA_STATE_RINGING -> {
                CallStreamHandler.sendEvent("Incoming: $number")
            }
            TelephonyManager.EXTRA_STATE_OFFHOOK -> {
                CallStreamHandler.sendEvent("Call Started")
            }
            TelephonyManager.EXTRA_STATE_IDLE -> {
                CallStreamHandler.sendEvent("Call Ended")
            }
        }
    }
}