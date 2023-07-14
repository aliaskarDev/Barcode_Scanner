import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/core/constants/const.dart';
import 'package:flutter_barcode_scanner/feature/main_screen/widgets/main_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, right: 18, left: 18, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              aboutApplication,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/scanner');
                  },
                  icon: const Icon(
                    Icons.camera_alt_sharp,
                  ),
                  title: 'scanner',
                ),
                MainButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/history');
                  },
                  icon: const Icon(
                    Icons.history_edu,
                  ),
                  title: 'history',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
