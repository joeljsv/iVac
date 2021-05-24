import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vacinefinder/utils/apptheme/constant.dart';

class QRcodeScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRcodeScannerState();
}

class _QRcodeScannerState extends State<QRcodeScanner> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    // if (result != null) Navigator.pop(context, result.code);
    return Scaffold(
      
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result == null)
                     Text('Scan a code'),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    String name = "";
    dynamic data;
    if (result != null) {
      try {
        data = json.decode(result.code);

        setState(() {
          name = data["name"] ?? "";
        });
      } catch (e) {
        print(e);
        setState(() {

          result = null;
        });
      }
    }

    return (result == null)
        ? QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$name",
                  style: kHeadingTextStyle.copyWith(fontSize: 26),
                ),
                TextButton(
                  child: Text("Click to continue"),
                  onPressed: () {
                    if (data != null) Navigator.pop(context, data);
                  },
                )
              ],
            ),
          );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    if (result == null)
      controller.scannedDataStream.listen((scanData) {
        print("Scanned data: ${scanData.code}");
        setState(() {
          result = scanData;
        });
      });
    // else
    //   Navigator.pop(context, result.code);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
