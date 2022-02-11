import 'package:deriv_go/features/home_screen/presentation/widgets/symbolList.dart';
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

///select symbol widget
class Symbols extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
        builder: (BuildContext context, dynamic state) {
          switch (state.runtimeType) {
            case ActiveSymbolLoading:
              //TODO: Show loader
              return Container();
            case ActiveSymbolLoaded:
              final ActiveSymbolLoaded thisState = state;
              /*final AvailableContractsCubit availableContracts =
                  context.read<AvailableContractsCubit>();

              availableContracts.loadContractsList(thisState.selectedSymbol);*/

              return Container(
                height: 100,
                child: Card(
                  child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                    builder: (BuildContext context, ActiveSymbolState state) =>
                        GestureDetector(
                      onTap: () {
                        final void Function(int index) _onChange =
                            context.read<ActiveSymbolCubit>().selectSymbol;

                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => ActiveSymbolList(
                              activeSymbol:
                                  thisState.activeSymbols ?? <ActiveSymbol>[],
                              selectSymbol: _onChange,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          ' Select Symbol: ${thisState.selectedSymbol?.symbol}',
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.expand_more),
                          onPressed: () {
                            final void Function(int index) _onChange =
                                context.read<ActiveSymbolCubit>().selectSymbol;

                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    ActiveSymbolList(
                                  activeSymbol: thisState.activeSymbols ??
                                      <ActiveSymbol>[],
                                  selectSymbol: _onChange,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      );
}
