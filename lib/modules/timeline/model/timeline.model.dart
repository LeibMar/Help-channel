
import 'dart:io';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';
import 'package:app_tcc/modules/timeline/view/timeline.view.dart';

class PostagemModel {


  Future<bool> sendDataToBackend(String text,  List<Map<String, dynamic>> filesData) async {




      // Definir a URL do servidor php
      var url = Uri.parse('http://localhost/conn2tcc.php');

      // Cria a request
      var request = http.MultipartRequest('POST', url);

      // Cria a request para o texto da mensagem
      request.fields['text'] = text;

    // Adiciona os arquivos anexados
    for (var i = 0; i < filesData.length; i++) {
      var fileData = filesData[i];
      //Uint8List fileBytes = filesBytes[i];
      Uint8List fileBytes = fileData['bytes'];
      String extension = fileData['extension'];

       // Extrai a extensão do arquivo

      request.files.add(http.MultipartFile.fromBytes(
        'file${i + 1}',
        fileBytes,
          filename: 'file${i + 1}.$extension',
          contentType: MediaType('application', 'octet-stream')

      ));
    }


    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Data sent successfully');
        return true;
      } else {
        print('Failed to send data. Server responded with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Failed to send data: $e');
      return false;
    }
  }
}
