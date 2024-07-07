import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:easy_coupon/bloc/canteen/bloc/canteen_bloc.dart';
import 'package:easy_coupon/bloc/canteen/bloc/canteen_event.dart';
import 'package:easy_coupon/bloc/canteen/bloc/canteen_state.dart';

import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';


class CanteenPage extends StatefulWidget {
  const CanteenPage({super.key});

  @override
  State<CanteenPage> createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage> {
  final GlobalKey globalKey = GlobalKey();

  final ScreenshotController screenshotController = ScreenshotController();
  String qrData = "Default QR Data"; // Set a default value
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
            return Center(child: CircularProgressIndicator());
          } else if (state is CanteenLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Screenshot(
                    controller: screenshotController,
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Container(
                        color: Colors.white,
                        child: Center(
                          child: QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Enter Username here",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (state.authorizedUsernames.contains(value)) {
                            qrData = value;
                            isValid = true;
                          } else {
                            qrData = "Default QR Data";
                            isValid = false;
                          }
                        });
                      },
                    ),
                  ),
                  if (!isValid)
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Invalid Username Please Try Again",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _shareQRCode,
                        icon: Icon(Icons.share),
                        label: Text('Share QR Code'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: _saveQRCode,
                        icon: Icon(Icons.save),
                        label: Text('Save QR Code'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is CanteenError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
