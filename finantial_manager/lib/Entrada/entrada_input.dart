import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Entrada/Entrada_controller.dart';
import 'package:finantial_manager/widgets/dialog.dart';
import 'package:finantial_manager/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputEntrada extends StatefulWidget {
  const InputEntrada({super.key});

  @override
  State<InputEntrada> createState() => _InputEntradaState();
}

class _InputEntradaState extends State<InputEntrada> {
  TextEditingController originController = TextEditingController(text: "");
  TextEditingController valueController = TextEditingController(text: "");
  bool isFixed = false;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInputField(
            controller: originController,
            label: "Origem",
          ),
          TextInputField(
            controller: valueController,
            label: "Valor",
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          Switch(
            thumbIcon: thumbIcon,
            value: isFixed,
            onChanged: (bool value) {
              setState(() {
                isFixed = value;
              });
            },
          ),
          FilledButton(
              onPressed: () {
                EntradaController.create(Entrada(
                    origin: originController.text,
                    value: double.parse(valueController.text),
                    dateTime: DateTime.now(),
                    isFixed: isFixed));
                Dialogs.showSucess(
                  context: context,
                  title: "Salvo com Sucesso!",
                  content: "Valor de Entrada inserido",
                );
              },
              child: const Text("Cadastrar")),
          // FilledButton(
          //     onPressed: () async {
          //       List list = await EntradaController.readAll();
          //       print(list.first.dateTime);
          //     },
          //     child: const Text("show data")),
          // FilledButton(
          //     onPressed: () async {
          //       List list = await EntradaController.fromPeriod(
          //         DateTime(2020).millisecondsSinceEpoch,
          //         DateTime(2024).millisecondsSinceEpoch,
          //       );
          //       print(list.first.dateTime);
          //     },
          //     child: const Text("show period")),
        ],
      ),
    );
  }
}
