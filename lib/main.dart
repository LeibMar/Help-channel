import 'package:flutter/material.dart';
import 'package:app_tcc/modules/timeline/view/timeline.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define initial route
      initialRoute: '/main', // Essa função defina a página principal
      // Abaixo a função para definir as rotas
      routes: {

        // por aqui novas rotas
        '/main': (context) => InputPage(), // Define route for your main page
      },

    );
  }
}
