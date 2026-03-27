import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static const EventChannel eventChannel = EventChannel('call_events');

  List<Map<String, String>> callLogs = [];

  @override
  void initState() {
    super.initState();
    requestPermission();
    listenCalls();
  }

  void listenCalls() {
    eventChannel.receiveBroadcastStream().listen((event) {
      setState(() {
        callLogs.insert(0, {
          "event": event.toString(),
          "time": TimeOfDay.now().format(context),
        });
      });
    });
  }

  Future<void> requestPermission() async {
    await Permission.phone.request();
  }

  Color getColor(String event) {
    if (event.contains("Incoming")) return Colors.green;
    if (event.contains("Ended")) return Colors.red;
    return Colors.blue;
  }

  IconData getIcon(String event) {
    if (event.contains("Incoming")) return Icons.call_received;
    if (event.contains("Ended")) return Icons.call_end;
    return Icons.call;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📞 Call History"),
        centerTitle: true,
      ),
      body: callLogs.isEmpty
          ? const Center(child: Text("No Calls Yet"))
          : ListView.builder(
        itemCount: callLogs.length,
        itemBuilder: (context, index) {
          final item = callLogs[index];

          return Card(
            margin:  EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(
                getIcon(item["event"]!),
                color: getColor(item["event"]!),
              ),
              title: Text(
                item["event"]!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getColor(item["event"]!),
                ),
              ),
              subtitle: Text("Time: ${item["time"]}"),
            ),
          );
        },
      ),
    );
  }
}