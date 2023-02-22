import 'package:finantial_manager/Entrada/entrada_input.dart';
import 'package:finantial_manager/widgets/dropdownbutton.dart';
import 'package:flutter/material.dart';

import '../Saida/saida_input.dart';

class CadastrosPage extends StatefulWidget {
  const CadastrosPage({super.key});

  @override
  State<CadastrosPage> createState() => _CadastrosPageState();
}

class _CadastrosPageState extends State<CadastrosPage> {
  List<String> tipos = ['Gasto', 'Entrada'];
  String value = 'Gasto';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyDropDownButton(
            options: tipos,
            value: value,
            labelText: "Tipos",
            onChanged: (newValue) {
              setState(() {
                value = newValue;
              });
            },
          ),
          Visibility(
            visible: value == tipos[0],
            child: const InputSaida(),
          ),
          Visibility(
            visible: value == tipos[1],
            child: const InputEntrada(),
          ),
        ],
      ),
    );
  }
}
