// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import '../../widgets/widgets.dart';

// class QrPage extends StatefulWidget {
//   const QrPage({super.key});

//   @override
//   State<QrPage> createState() => _QrPageState();
// }

// class _QrPageState extends State<QrPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   void reassemble() {
//     super.reassemble();
//     if (controller != null) {
//       controller!.pauseCamera();
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(CupertinoIcons.back, color: Colors.black),
//           onPressed: () {
//             Navigator.pushNamed(context, '/student');
//           },
//         ),
//         title: const Text(
//           'Student Page',
//           textAlign: TextAlign.left,
//         ),
//         backgroundColor: const Color(0xFFFCD170),
//         actions: const [
//           Padding(
//             padding: EdgeInsets.only(right: 25.0),
//             child: UserProfileAvatar(),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Define a base width for iPhone 12 Pro
//           double baseWidth = 390.0;
//           // Calculate the scale factor
//           double scaleFactor = constraints.maxWidth / baseWidth;

//           return Container(
//             padding: const EdgeInsets.all(20),
//             color: const Color(0xFFF9E6BD),
//             child: Center(
//               child: Container(
//                 width: constraints.maxWidth * 0.9,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFFCD170),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 40), // Spacer to push content down
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Stack(
//                         children: [
//                           Image.asset(
//                             'assets/studentImage.jpg',
//                             width: constraints.maxWidth * 0.8,
//                             fit: BoxFit.cover,
//                           ),
//                           Positioned(
//                             left: 20,
//                             top: 10,
//                             child: Text(
//                               'The Reliable\nCoupon System',
//                               style: TextStyle(
//                                 fontSize: 18.0 * scaleFactor,
//                                 fontWeight: FontWeight.w800,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20 * scaleFactor), // Spacer below image
//                     Text(
//                       'Hold the phone to scan the QR code',
//                       style: TextStyle(
//                         fontSize: 16.0 * scaleFactor,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(height: 20 * scaleFactor), // Spacer before QR scanner
//                     Container(
//                       height: 200 * scaleFactor,
//                       width: 200 * scaleFactor,
//                       child: QRView(
//                         key: qrKey,
//                         onQRViewCreated: _onQRViewCreated,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BottomNavBar(
//         currentIndex: 0, // settings is the 4th item
//         onTap: (index) {
//           // Handle bottom navigation tap
//         },
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../widgets/widgets.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/student');
          },
        ),
        title: const Text(
          'Student Page',
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xFFFCD170),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: UserProfileAvatar(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define a base width for iPhone 12 Pro
          double baseWidth = 390.0;
          // Calculate the scale factor
          double scaleFactor = constraints.maxWidth / baseWidth;

          return Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF9E6BD),
            child: Center(
              child: Container(
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCD170),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40), // Spacer to push content down
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/studentImage.jpg',
                            width: constraints.maxWidth * 0.8,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 20,
                            top: 10,
                            child: Text(
                              'The Reliable\nCoupon System',
                              style: TextStyle(
                                fontSize: 18.0 * scaleFactor,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20 * scaleFactor), // Spacer below image
                    Text(
                      'Hold the phone to scan the QR code',
                      style: TextStyle(
                        fontSize: 16.0 * scaleFactor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20 * scaleFactor), // Spacer before QR scanner
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: 200 * scaleFactor,
                          width: 200 * scaleFactor,
                          child: QRView(
                            key: qrKey,
                            overlay: QrScannerOverlayShape(
                              borderColor: Colors.red,
                              borderRadius: 10,
                              borderLength: 30,
                              borderWidth: 10,
                              cutOutSize: 200 * scaleFactor,
                            ),
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0, // settings is the 4th item
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}


