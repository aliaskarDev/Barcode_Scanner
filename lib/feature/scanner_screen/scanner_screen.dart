import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/feature/history/history_screen.dart';
import 'package:flutter_barcode_scanner/feature/scanner_screen/widgets/found_code_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobile Scanner"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // allowDuplicates: true,
        controller: cameraController,
        onDetect: _foundBarcode,
      ),
    );
  }

  void _foundBarcode(BarcodeCapture barcodeCapture) {
    /// open screen
    if (!_screenOpened) {
      final listofBarcodes = barcodeCapture.barcodes;
      final code = listofBarcodes;
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      print('Print ${listofBarcodes.length}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoundCodeScreen(
            screenClosed: _screenWasClosed,
            value: code,
            index: listofBarcodes.length,
          ),
        ),
      );
      var box = Hive.box('myBox');
      box.put(
        code.first.rawValue.toString(),
        code.first.rawValue,
      );
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
