import 'dart:convert';
import 'dart:io';

import 'package:emoraa/components/qr_code/qr_code_generate.dart';
import 'package:emoraa/components/qr_code/qr_code_scanner_page.dart';
import 'package:emoraa/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:recognition_qrcode/recognition_qrcode.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

final TextEditingController _controllerText = TextEditingController();
final GlobalKey globalKey = GlobalKey();

HousePaymentModel? result;
String resultHex = "";
String file_path = "";

class _PaymentPageState extends State<PaymentPage> {
  late String _qrData;
  _converttoHex() async {
    var jsonString = _controllerText.text;
    setState(() {
      resultHex = HEX.encode(utf8.encode(jsonString));
    });
  }

  _converttoText() {
    var decodedBytes = HEX.decode(resultHex);
    var decodedString = utf8.decode(decodedBytes);
    var decodedData = jsonDecode(decodedString.toString());
    setState(() {
      if (decodedData is Map<String, dynamic>) {
        try {
          result = HousePaymentModel(
            ownerId: decodedData['ownerId'],
            amount: decodedData['amount'],
            loyerId: decodedData['loyerId'],
            date: decodedData['date'],
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      }
    });
  }

  _selectImgFromGallery() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 10);
      if (file != null) {
        RecognitionQrcode.recognition(file.path).then((result) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.toString())));
          setState(() {
            resultHex = result['value'];
          });
        _converttoText();
        });

        return file.path;
      }
      return "";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: const FlexibleSpaceBar(
            background: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 40, 125, 237),
                Color.fromARGB(255, 242, 75, 33),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controllerText,
              decoration: const InputDecoration(
                hintText: 'Data to convert',
              ),
            ),
            Text(resultHex),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Owner id: ${result?.ownerId}"),
                Text("User id : ${result?.loyerId}"),
                Text("Amount : ${result?.amount}"),
                Text("Date : ${result?.date}"),
                if (resultHex.isNotEmpty)
                  QrImageView(
                    data: resultHex,
                    size: 200,
                  )
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => CreateQrCode(
                          textQrCode: resultHex,
                        )),
                  ),
                );
              },
              child: const Text("Generate Qr code"),
            ),
            if (file_path != "")
              Image.file(
                File(file_path),
                width: 100,
                height: 100,
              ),
            ElevatedButton(
              onPressed: _converttoHex,
              child: const Text('Convert to hexadecimal'),
            ),
            ElevatedButton(
              onPressed: _converttoText,
              child: const Text('Convert to readable data'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  file_path = _selectImgFromGallery();
                });
              },
              child: const Text("QR Image"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const QrCodeGenerate()));
              },
              child: const Text('Scan qr code'),
            )
          ],
        ),
      ),
    );
  }
}
