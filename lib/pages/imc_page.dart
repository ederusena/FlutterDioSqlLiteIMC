import 'package:dio_imc_flutter/models/imc.dart';
import 'package:dio_imc_flutter/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  ImcRepository imcRepository = ImcRepository();

  var _imclist = const <Imc>[];
  var imcCalculate = 0.0;
  var imcStatus = "";

  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obterLista();
  }

  void obterLista() async {
    _imclist = await imcRepository.getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Calcule seu IMC",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Digite seu peso (kg)",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Digite sua altura (cm)",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  imcCalculate = await imcRepository.calculateImc(
                      double.parse(pesoController.text),
                      double.parse(alturaController.text));

                  imcStatus = await imcRepository.getImcStatus(imcCalculate);
                  await imcRepository.salvar(Imc(
                      0,
                      double.parse(pesoController.text),
                      double.parse(alturaController.text),
                      imcCalculate,
                      imcStatus));

                  obterLista();
                },
                child: const Text(
                  "Calcular",
                  style: TextStyle(fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            if (_imclist.isNotEmpty)
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _imclist.length,
                    itemBuilder: (context, index) {
                      var imc = _imclist[index];
                      return Container(
                        margin: const EdgeInsets.all(4),
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                              "Peso: ${imc.weight} - Altura: ${imc.height}"),
                          subtitle:
                              Text('IMC: ${imc.imc}\nStatus: ${imc.status}'),
                          tileColor: Colors.cyan,
                        ),
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
