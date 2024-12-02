import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_match/screens/login_screen.dart';
import 'app_state.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(), // AppState criado uma única vez
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 229, 191, 191)),
        // Aplicando Montserrat a todo o texto
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme, // Herda o estilo padrão de texto
        ),
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 249, 249, 249), // Cor de fundo de todas as páginas
      ),
      home: const LoginScreen(),
    );
  }
}
