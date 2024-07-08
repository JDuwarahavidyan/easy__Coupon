// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QrPage extends StatefulWidget {
//   const QrPage({super.key});

//   @override
//   _QrPageState createState() => _QrPageState();
// }

// class _QrPageState extends State<QrPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String qrText = '';

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   void _onQRViewCreated(QRViewController qrViewController) {
//     setState(() {
//       this.controller = qrViewController;
//     });
//     controller!.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData.code ?? '';
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           QRView(
//             key: qrKey,
//             onQRViewCreated: _onQRViewCreated,
//             overlay: QrScannerOverlayShape(
//               borderColor: Colors.transparent,
//               cutOutSize: MediaQuery.of(context).size.width * 0.8,
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 20,
//             child: IconButton(
//               icon: const Icon(Icons.close, color: Colors.white, size: 30),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/student');
//               },
//             ),
//           ),
//           Positioned(
//             top: MediaQuery.of(context).size.height * 0.15,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Text(
//                   'Place the QR Code inside the area',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Scanning will start automatically',
//                   style: TextStyle(fontSize: 14, color: Colors.white),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//           CustomPaint(
//             painter: ScannerOverlayPainter(),
//             child: Container(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ScannerOverlayPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.black.withOpacity(0.5)
//       ..style = PaintingStyle.fill;

//     final rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     final cutOutRect = RRect.fromRectAndRadius(
//       Rect.fromCenter(
//       center: Offset(size.width / 2, size.height / 2),
//       width: size.width * 0.8,
//       height: size.width * 0.8,
//     ),
//      Radius.circular(20),
//     );

//     final path = Path()
//       ..addRect(rect)
//       ..addRect(cutOutRect)
//       ..fillType = PathFillType.evenOdd;

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

import 'package:easy_coupon/models/students/functions.dart';
import 'package:easy_coupon/pages/student/student_home.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';
  Barcode? result;

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
        scanned_data(result!);
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
          CustomPaint(
            painter: ScannerOverlayPainter(),
            child: Container(),
          ),
          Positioned(
            top: 40,
            left: 20,
            /*child: ElevatedButton(
              onPressed: () =>
                  {Navigator.pushReplacementNamed(context, '/student')},
              child: const Text("Go to 1st page"),
            ),*/
            child: IconButton(
              icon: const Icon(Icons.backspace_sharp,
                  color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/student');
              },
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
      Radius.circular(20),
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
