import 'package:flutter/material.dart';
import 'package:app_tcc/modules/timeline/model/timeline.model.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
// sempre que for passar uma página como parametro para um rota, chamar a funçao rota no arquivo main.dart
// e usar o nome da primeira classe que aparece na página como parametro (no caso aqui é a classe InputPage)
class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController textController = TextEditingController();
  PostagemModel _postagemModel = PostagemModel();
  //List<Uint8List> selectedFilesBytes = [];
  List<Map<String, dynamic>> selectedFilesData = [];

  Future<void> _pickFiles() async {
    //selectedFilesBytes.clear();
    selectedFilesData.clear();

    final FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<PlatformFile> files = result.files;
      for (var file in files) {
        //selectedFilesBytes.add(file.bytes!);
        Uint8List fileBytes = file.bytes!;
        String extension = file.extension ?? '';
        selectedFilesData.add({
          'bytes': fileBytes,
          //'bytes': selectedFilesBytes,
          'extension': extension,
        });

      }
    } else {
      // User canceled the picker
    }

    if (selectedFilesData.isEmpty) {
      print("No files selected.");
    }
  }
  void _submitData() async {
    String text = textController.text;

if (selectedFilesData.isEmpty) {
  bool success = await _postagemModel.sendDataToBackend(text, []);
    if (success) {
      print("text Data sent successfully");
      //print(_postagemModel.sendDataToBackend(text, selectedFilesBytes as List<Uint8List>));
      // Data sent successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Postagem enviada com sucesso'),
        ),
      );
    }}
       else { if (selectedFilesData.isNotEmpty) {

    // Files selected, send both text and files
    bool success = await _postagemModel.sendDataToBackend(text, selectedFilesData);
    if (success) {
    print("Data sent successfully");
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text('Postagem enviada com sucesso'),
    ),
    );
    }
  }}
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Postagens'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: 'Insira sua postagem',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _pickFiles,
              child: Text('Upload Files'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Postar'),
            ),
          ],
        ),
      ),
    );
  }
}