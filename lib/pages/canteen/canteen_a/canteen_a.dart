import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CanteenPage extends StatefulWidget {
  const CanteenPage({super.key});

  @override
  State<CanteenPage> createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage> {
  final GlobalKey globalKey = GlobalKey();
  String qrData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
        backgroundColor: const Color(0xFFFCD170),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            RepaintBoundary(
              key: globalKey,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: qrData.isEmpty
                      ? const Text(
                          "Enter Data To Generate QR Code",
                          style: TextStyle(fontSize: 20, color: Colors.indigo),
                        )
                      : QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: 200,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Enter Data",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    qrData = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*class _CanteenState extends State<Canteen> {
  String _qrData = "";

  @override
  void initState() {
    super.initState();
    _generateQRData();
  }

  void _generateQRData() {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final qrString = List.generate(
        10, (index) => characters[random.nextInt(characters.length)]).join();
    setState(() {
      _qrData = qrString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random QR Generator'),
        backgroundColor: const Color(0xFFFCD170),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: _qrData,
              size: 200.0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateQRData,
              child: const Text('Generate New QR Code'),
            ),
            const SizedBox(height: 20),
            Text('QR Data: $_qrData'),
          ],
        ),
      ),
    );
  }
}*/
