import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../states/active_symbol/active_symbol_cubit.dart';
import '../../states/available_contracts/available_contracts_cubit.dart';
import '../widgets/contract_list.dart';
import '../widgets/data_widget.dart';
import '../widgets/symbol.dart';

///The home page of the app
class HomeScreen extends StatefulWidget {
  /// constructor for home page
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ActiveSymbolCubit _activeSymbolCubit;
  late AvailableContractsCubit _availableContractsCubit;

  @override
  void initState() {
    super.initState();
    _activeSymbolCubit = ActiveSymbolCubit()..loadActiveSymbols();
    _availableContractsCubit = AvailableContractsCubit(_activeSymbolCubit);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Deriv Go'),
        ),
        body: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<ActiveSymbolCubit>.value(
              value: _activeSymbolCubit,
            ),
            BlocProvider<AvailableContractsCubit>.value(
              value: _availableContractsCubit,
            ),
          ],
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Symbols(),
              DataWidget(activeSymbolCubit: _activeSymbolCubit),
              const AvailableContractsList(),
            ],
          ),
        ),
      );
}
