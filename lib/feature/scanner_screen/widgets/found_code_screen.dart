import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/feature/history/history_screen.dart';
import 'package:flutter_barcode_scanner/feature/main_screen/widgets/main_button.dart';
import 'package:hive/hive.dart';

class FoundCodeScreen extends StatefulWidget {
  final value;
  final index;
  final Function() screenClosed;
  const FoundCodeScreen(
      {Key? key, required this.value, required this.screenClosed, this.index})
      : super(key: key);

  @override
  State<FoundCodeScreen> createState() => _FoundCodeScreenState();
}

class _FoundCodeScreenState extends State<FoundCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Found Code"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            widget.screenClosed();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Scanned Code:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.value.first.rawValue,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MainButton(
                icon: const Icon(Icons.save_alt),
                title: 'save info',
                onTap: () {
                  var box = Hive.box('myBox');
                  box.put(
                    widget.value.first.rawValue.toString(),
                    widget.value.first.rawValue,
                  );
                  print('PRINT ${widget.value.first.rawValue}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(
                        mybarcodes: widget.value,
                        index: widget.value?.length ?? 1,
                      ),
                    ),
                  );
                },
              ),
              MainButton(
                icon: const Icon(Icons.cancel),
                title: 'cancel',
                onTap: () {
                  var box = Hive.box('myBox');
                  // ignore: unused_local_variable
                  var data = box.delete(
                    widget.value.last.rawValue,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
