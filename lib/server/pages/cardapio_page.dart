import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class CardapioPage extends StatefulWidget {
  const CardapioPage({Key? key}) : super(key: key);

  @override
  State<CardapioPage> createState() => _CardapioPageState();
}

class _CardapioPageState extends State<CardapioPage> {
  FilePickerResult? result;
  var filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Cardápio",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 100),
              child: DottedBorder(
                color: Colors.black,
                strokeWidth: 2,
                dashPattern: const [8, 5],
                child: GestureDetector(
                  onTap: () async {
                    result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowCompression: true,
                      allowMultiple: false,
                      allowedExtensions: ['pdf'],
                    );
                    if (result == null) {
                      return;
                    } else {
                      result?.files.forEach((element) {
                        filePath = element.name!;
                        setState(() {});
                      });
                    }
                    print(result);
                  },
                  child: SizedBox(
                    height: 424,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 90, 18, 22),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              'assets/images/cloud-upload.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 306,
                          height: 48,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Faça o upload do cardápio em pdf aqui.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Figtree',
                              fontWeight: FontWeight.w300,
                              height: 0.09,
                              letterSpacing: 0.36,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (result != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 325,
                              height: 63,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFE6E6E6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/pdf.png',
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      filePath,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                        fontFamily: 'Figtree',
                                        fontWeight: FontWeight.w300,
                                        height: 0.15,
                                        letterSpacing: -0.08,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              )),
          DefaultButton(
            onPressed: () {
              // Lógica específica para essa tela
            },
            buttonText: "Salvar",
          ),
        ],
      ),
    );
  }
}
