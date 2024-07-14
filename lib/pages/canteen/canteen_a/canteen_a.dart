import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:easy_coupon/bloc/blocs.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';

class CanteenAPage extends StatefulWidget {
  const CanteenAPage({super.key});

  @override
  State<CanteenAPage> createState() => _CanteenAPageState();
}

class _CanteenAPageState extends State<CanteenAPage> {
  final GlobalKey globalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();
  String qrData = "CanteenA_QR_Code";
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    context.read<CanteenBloc>().add(FetchAuthorizedUsers());
  }

  Future<void> _shareQRCode() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      Share.shareFiles([imagePath.path], text: 'Here is my QR code');
    }
  }

  Future<void> _saveQRCode() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR code saved to ${imagePath.path}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
        backgroundColor: const Color(0xFFFCD170),
      ),
      body: BlocBuilder<CanteenBloc, CanteenState>(
        builder: (context, state) {
          if (state is CanteenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CanteenLoaded) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFFF9E6BD),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFCD170),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Here is your QR',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Screenshot(
                        controller: screenshotController,
                        child: RepaintBoundary(
                          key: globalKey,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            child: QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _shareQRCode,
                            icon: const Icon(Icons.share),
                            label: const Text('Share QR Code'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: _saveQRCode,
                            icon: const Icon(Icons.save),
                            label: const Text('Save QR Code'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is CanteenError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
