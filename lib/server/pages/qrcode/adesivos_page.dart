import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'download_qrcode_page.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cardapio_v_0/widgets/widgets.dart';

class AdesivosPage extends StatefulWidget {
  final int count;

  const AdesivosPage({Key? key, required this.count}) : super(key: key);

  @override
  State<AdesivosPage> createState() => _AdesivosPageState();
}

class _AdesivosPageState extends State<AdesivosPage> {
  final TextEditingController textQr = TextEditingController();
  String textQrCodeScan = "";

  Future<void> scanQrCode() async {
    try {
      final qrCod = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.QR);
      if (qrCod.isNotEmpty) {
        print("My code qr : $qrCod");
        textQrCodeScan = qrCod;
        setState(() {});
      }
    } on PlatformException {
      print("exception");
    }
  }

  List<Widget> buildAdesivos() {
    List<Widget> adesivos = [];

    for (int i = 1; i <= widget.count; i++) {
      adesivos.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DownloadQrCodePage(
                  textQrCode: "CÓDIGO_QR_AQUI",
                  // Substitua pelo seu código QR
                  count: i, // Adicione o número da mesa como parâmetro
                ),
              ),
            );
            print('Toque na mesa $i');
          },
          child: Stack(
            children: [
              Image.asset(
                'assets/icons/qr_table.png',
                height: 95,
                width: 95,
              ),
              Positioned(
                top: 28,
                left: 29,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$i',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Espaçamento entre o número e o ícone
                    const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 36,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return adesivos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Adesivos",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                // Defina o número de colunas conforme necessário
                children: buildAdesivos(),
              ),
            ),
            DefaultButton(
                onPressed: () {},
                buttonText: "Baixar QR Code de todas as mesas")
          ],
        ),
      ),
    );
  }
}
