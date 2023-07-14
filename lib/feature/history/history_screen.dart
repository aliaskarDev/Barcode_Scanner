import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, this.mybarcodes, this.index});
  final List<Barcode>? mybarcodes;
  final int? index;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('myBox');
    box.get(
      mybarcodes?.first.rawValue.toString() ?? '',
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mybarcodes?.length ?? 1,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.white,
                    child: Text(mybarcodes?[index].rawValue ?? ''),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
