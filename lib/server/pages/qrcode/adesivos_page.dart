import 'package:flutter/material.dart';
import 'download_qrcode_page.dart';

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
                  textQrCode: "http://192.168.0.9:3000/mesa/$i/callingWaiter",
                  count: i,
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
                top: 16,
                left: 29,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$i',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Figtree',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white,
                      size: 32,
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
