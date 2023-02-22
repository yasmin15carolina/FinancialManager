import 'package:finantial_manager/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dialogs {
  static show({String? title, String? content, context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            FilledButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showSucess({String? title, String? content, context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
          actions: <Widget>[
            // define os botões na base do dialogo
            FilledButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showEdit(
      {required TextEditingController movimentacao,
      required TextEditingController valor,
      required Function onConfirm,
      context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: const Text("Editar"),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: Column(
              children: [
                TextInputField(
                  controller: movimentacao,
                  label: "Motivo",
                ),
                TextInputField(
                  controller: valor,
                  label: "Valor",
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // define os botões na base do dialogo
            FilledButton(
              child: const Text("Ok"),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static showDelete({required Function onConfirm, context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: const Text("Deletar"),
          content: const Text("Excluir item?"),
          actions: <Widget>[
            // define os botões na base do dialogo
            FilledButton(
              child: const Text("Ok"),
              onPressed: () {
                onConfirm();
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
