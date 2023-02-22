import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:finantial_manager/pages/cadastros_page.dart';
import 'package:finantial_manager/pages/results_page.dart';
import 'package:flutter/material.dart';

import '../Saida/saida_grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? tabController;
  List<Saida>? saidas = [];
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    Future.delayed(Duration.zero, () async {
      tabController!.addListener(() async {
        if (tabController!.indexIsChanging) {
          saidas = await SaidaController.readAll();
          setState(() {});
          debugPrint(saidas.toString());
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // appBar: AppBar(
          //   bottom: const TabBar(
          //     tabs: [
          //       Tab(icon: Text("Inserir")),
          //       Tab(icon: Text("Gastos")),
          //     ],
          //   ),
          //   title: const Text('Tabs Demo'),
          // ),
          body: TabBarView(
            controller: tabController,
            children: [
              const CadastrosPage(),
              GridSaida(
                gastos: saidas!,
              ),
              const ResultsPage()
            ],
          ),
          bottomNavigationBar: menu()
          //  BottomAppBar(
          //   shape: null,
          //   color: Theme.of(context).primaryColor,
          //   // notchMargin: SizeConfig.of(context).dynamicScaleSize(size: 8)!,
          //   child: Container(
          //     // height: SizeConfig.of(context).dynamicScaleSize(size: 50),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: <Widget>[
          //         Tab(icon: Text("Inserir")),
          //         Tab(icon: Text("Inserir")),
          //       ],
          //     ),
          //   ),
          // ),
          ),
    );
  }

  Widget menu() {
    return TabBar(
      controller: tabController,
      // labelColor: Colors.white,
      // unselectedLabelColor: Colors.white70,
      // indicatorSize: TabBarIndicatorSize.tab,
      // indicatorPadding: EdgeInsets.all(5.0),
      // indicatorColor: Colors.blue,
      tabs: const [
        Tab(
          text: "Inserir",
          icon: Icon(Icons.attach_money_outlined),
        ),
        Tab(
          text: "Gastos",
          icon: Icon(Icons.grid_on_rounded),
        ),
        Tab(
          text: "Result",
          icon: Icon(Icons.list),
        ),
      ],
    );
  }
}
