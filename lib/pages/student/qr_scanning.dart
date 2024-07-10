import 'package:easy_coupon/models/functions.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrPage extends StatefulWidget {
  final int val;
  const QrPage({super.key, required this.val});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';
  Barcode? result;
  int loops = 0;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });
    controller?.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      // Handle the scanned data
      if (result != null) {
        if ((result?.code == "canteenA" || result?.code == "canteenB") &&
            loops <= 0) {
          scanned_data(result!, widget.val);
          Navigator.pushReplacementNamed(
            context,
            '/student',
          );
          loops++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.transparent,
              cutOutSize: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: Container(),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/student',
                  (route) => false,
                );
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: const Column(
              children: [
                Text(
                  'Place the QR Code inside the area',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  'Scanning will start automatically',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final cutOutRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.8,
        height: size.width * 0.8,
      ),
      const Radius.circular(20),
    );

    final path = Path()
      ..addRect(rect)
      ..addRRect(cutOutRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
