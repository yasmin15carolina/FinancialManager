import 'package:finantial_manager/Entrada/entrada_grid.dart';
import 'package:finantial_manager/Saida/saida_grid.dart';
import 'package:finantial_manager/pages/cadastros_page.dart';
import 'package:finantial_manager/pages/results_page.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int index = 1;
  final screens = [
    const CadastrosPage(),
    GridSaida(
      gastos: const [],
    ),
    GridEntrada(
      entrada: const [],
    ),
    const ResultsPage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            // indicatorColor: Colors.white,
            labelTextStyle: MaterialStateProperty.all(const TextStyle())),
        child: NavigationBar(
          height: 60,
          // backgroundColor: Colors.red,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.attach_money), label: "Inserir"),
            NavigationDestination(
                icon: Icon(Icons.grid_on_rounded, color: Colors.red),
                label: "Gastos"),
            NavigationDestination(
                icon: Icon(Icons.grid_on_rounded, color: Colors.green),
                label: "Entrada"),
            NavigationDestination(
                icon: Icon(Icons.list_rounded), label: "Resultado"),
          ],
        ),
      ),
    );
  }
}
