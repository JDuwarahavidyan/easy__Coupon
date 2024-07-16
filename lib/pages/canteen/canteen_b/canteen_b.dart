import 'dart:io';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CanteenBPage extends StatefulWidget {
  const CanteenBPage({super.key});

  @override
  State<CanteenBPage> createState() => _CanteenBPageState();
}

class _CanteenBPageState extends State<CanteenBPage> {
  final GlobalKey globalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      context.read<UserBloc>().add(UserGenerateQREvent(userId));
    }
  }

  Future<void> _shareQRCode(String qrData) async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      Share.shareFiles([imagePath.path], text: 'Here is my QR code: $qrData');
    }
  }

  Future<void> _saveQRCode(String qrData) async {
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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserQRGenerated) {
            final qrData = state.qrData; // Updated to use the generated QR data
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
                            onPressed: () => _shareQRCode(qrData),
                            icon: const Icon(Icons.share),
                            label: const Text('Share QR Code'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () => _saveQRCode(qrData),
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
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
