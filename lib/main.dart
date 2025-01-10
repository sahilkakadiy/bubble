import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dash Bubble Playground',
      home: BubblePage(),
    );
  }
}

class BubblePage extends StatefulWidget {
  @override
  _BubblePageState createState() => _BubblePageState();
}

class _BubblePageState extends State<BubblePage> {
  void _logMessage({required BuildContext context, required String message}) {
    print(message);
  }

  // Method to request overlay permission
  Future<void> requestOverlay() async {
    final status = await DashBubble.instance.requestOverlayPermission();
    if (status == true) {
      _logMessage(context: context, message: 'Overlay Permission Granted');
    } else {
      _logMessage(context: context, message: 'Overlay Permission Denied');
    }
  }

  Future<void> startBubble(
      {BubbleOptions? bubbleOptions, VoidCallback? onTap}) async {
    try {
      final hasStarted = await DashBubble.instance.startBubble(
        bubbleOptions: bubbleOptions,
        onTap: onTap,
      );

      if (hasStarted == true) {
        print("Bubble is started");
      } else {
        print("Bubble is not started");
      }
    } catch (e) {
      print("Error starting bubble: $e");
    }
  }

  Future<void> stopBubble() async {
    final hasStopped = await DashBubble.instance.stopBubble();
    if (hasStopped == true) {
      print("Bubble is stopped");
    } else {
      print("Bubble is not stopped");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(),
      appBar: AppBar(title: Text('Bubble Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                requestOverlay();
              },
              child: Text("Request Overlay"),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                startBubble(
                  bubbleOptions: BubbleOptions(
                    bubbleIcon: "assets/Apps.png",
                    bubbleSize: 140,
                    enableClose: false,
                    distanceToClose: 90,
                    enableAnimateToEdge: true,
                    enableBottomShadow: true,
                    keepAliveWhenAppExit: false,
                  ),
                );
              },
              child: Text('Start Bubble'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                stopBubble();
              },
              child: Text("Stop Bubble"),
            ),
          ],
        ),
      ),
    );
  }
}
