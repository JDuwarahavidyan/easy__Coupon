import 'dart:io';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class QRGenerationPage extends StatefulWidget {
  final UserModel user;
  const QRGenerationPage({super.key, required this.user});


  @override
  State<QRGenerationPage> createState() => _QRGenerationPageState();
}

class _QRGenerationPageState extends State<QRGenerationPage> {
  final GlobalKey globalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();
  String? qrData;

  // Define static key and IV
  final key = encrypt.Key.fromUtf8('easycouponkey@ruhunaengfac22TDDS');
  final iv = encrypt.IV.fromUtf8('easyduwa');

  @override
  void initState() {
    super.initState();
    final canteenUserId = FirebaseAuth.instance.currentUser?.uid;
    if (canteenUserId != null) {
      context.read<UserBloc>().add(UserGenerateQREvent(canteenUserId));
    }
  }

  String encryptData(String data) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  Future<void> _shareQRCode() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      if (qrData != null) {
        Share.shareFiles([imagePath.path], text: 'Here is my QR code: $qrData');
      }
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
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserQRGenerated) {
            final encryptedData = encryptData(state.qrData);
            setState(() {
              qrData = encryptedData; // Store encrypted QR data in the state
            });
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserQRGenerated || qrData != null) {
            final displayQRData = qrData ?? '';
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
                              data: displayQRData,
                              version: QrVersions.auto,
                              size: 300,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
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
                          const SizedBox(height: 20),
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
          }
          return const Center(child: Text('Failed to load user data'));
        },
      ),
    );
  }
}
