import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cardapio_v_0/widgets/widgets.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';

class DownloadQrCodePage extends StatefulWidget {
  final String? textQrCode;
  final int count;
  const DownloadQrCodePage({Key? key, this.textQrCode, required this.count})
      : super(key: key);
  @override
  State<DownloadQrCodePage> createState() => _DownloadQrCodePageState();
}

class _DownloadQrCodePageState extends State<DownloadQrCodePage> {
  final GlobalKey globalKey = GlobalKey();

  Future<void> converQrCodeToImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$directory/qrCode.png");
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path], text: "Your text share");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, right: 25),
              width: double.infinity,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.navigate_before_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Adesivos",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w400,
                          height: 0.08,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: SizedBox(
                height: 395,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120, 20, 100, 15),
                      child: Text(
                        'MESA ${widget.count}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Figtree',
                          fontWeight: FontWeight.w500,
                          height: 0.05,
                          letterSpacing: 0.36,
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 25, 25, 25),
                      child: Center(
                        child: RepaintBoundary(
                          key: globalKey,
                          child: QrImage(
                            data: "${widget.textQrCode}",
                            version: QrVersions.auto,
                            size: 280,
                            backgroundColor: Colors.white,
                            gapless: true,
                            errorStateBuilder: (cxt, err) {
                              return const Center(
                                child: Text("Error"),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            DefaultButton(onPressed: () {}, buttonText: "Baixar QR Code")
          ],
        ),
      ),
    );
  }
}
