import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:finantial_manager/widgets/dialog.dart';
import 'package:finantial_manager/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputSaida extends StatefulWidget {
  const InputSaida({super.key});

  @override
  State<InputSaida> createState() => _InputSaidaState();
}

class _InputSaidaState extends State<InputSaida> {
  TextEditingController reasonController = TextEditingController(text: "aa");
  TextEditingController valueController = TextEditingController(text: "9.99");
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
            controller: reasonController,
            label: "Motivo",
          ),
          TextInputField(
            controller: valueController,
            label: "Valor",
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Fixo",
                style: TextStyle(fontSize: 15),
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
            ],
          ),
          FilledButton(
              onPressed: () {
                SaidaController.create(Saida(
                    reason: reasonController.text,
                    value: double.parse(valueController.text),
                    dateTime: DateTime.now(),
                    isFixed: isFixed));
                Dialogs.showSucess(
                  context: context,
                  title: "Salvo com Sucesso!",
                  content: "Valor de Saída inserido",
                );
              },
              child: const Text("Cadastrar")),
          // FilledButton(
          //     onPressed: () async {
          //       List<Saida> list = await SaidaController.readAll();
          //       // await ManagerDatabase.instance.readAllGastos();
          //       print(list.first.dateTime);
          //     },
          //     child: const Text("show data")),
          // FilledButton(
          //     onPressed: () async {
          //       await Arquivo.saveFile();
          //     },
          //     child: const Text("save data")),
          // FilledButton(
          //     onPressed: () async {
          //       await SaidaController.getRows();
          //     },
          //     child: const Text("save data")),
        ],
      ),
    );
  }
}
