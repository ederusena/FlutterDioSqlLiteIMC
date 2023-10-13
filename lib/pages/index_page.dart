import 'package:dio_imc_flutter/pages/imc_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 73, 207, 129),
        title: const Text(
          "DIO IMC Calculator - SQLite",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (value) => {setState(() => posicaoPagina = value)},
            children: const [ImcPage()],
          ))
        ],
      ),
    ));
  }
}
