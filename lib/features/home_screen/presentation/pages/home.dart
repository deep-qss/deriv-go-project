import 'package:deriv_go/features/home_screen/presentation/widgets/symbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../states/active_symbol/active_symbol_cubit.dart';
import '../../states/available_contracts/available_contracts_cubit.dart';
import '../widgets/contract_list.dart';
import '../widgets/data_widget.dart';

///The home page of the app
class HomeScreen extends StatelessWidget {
  /// constructor for home page
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Deriv Go'),
        ),
        body: MultiBlocProvider(
          providers: <BlocProvider<dynamic>>[
            BlocProvider<ActiveSymbolCubit>(
              create: (BuildContext context) =>
                  ActiveSymbolCubit()..loadActiveSymbols(),
            ),
            BlocProvider<AvailableContractsCubit>(
              create: (BuildContext context) =>
                  AvailableContractsCubit(context.read<ActiveSymbolCubit>()),
            ),
          ],
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Symbols(),
              DataWidget(),
              const AvailableContractList(),
            ],
          ),
        ),
      );
}
