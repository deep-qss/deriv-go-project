import 'package:bloc/bloc.dart';
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/exceptions/contract_for_symbol_exception.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:meta/meta.dart';

part 'available_contracts_state.dart';

/// To manage available contracts
class AvailableContractsCubit extends Cubit<AvailableContractsState> {
  ///initializer
  AvailableContractsCubit(ActiveSymbolCubit activeSymbolCubit)
      : super(AvailableContractsLoading()) {
    activeSymbolCubit.stream.listen((ActiveSymbolState activeSymbolState) {
      if (activeSymbolState is ActiveSymbolLoaded) {
        final ActiveSymbol? symbol = activeSymbolState.selectedSymbol;
        if (symbol != null) {
          _loadContractsList(symbol);
        }
      }
    });
  }

  /// fetch available contracts
  /// [symbol] To fetch available contracts for specified symbol
  Future<ContractsForSymbol> _fetchAvailableContracts(
          ActiveSymbol? symbol) async =>
      ContractsForSymbol.fetchContractsForSymbol(
          ContractsForRequest(contractsFor: symbol?.symbol));

  Future<void> _loadContractsList(ActiveSymbol? activeSymbol) async {
    try {
      final ContractsForSymbol contracts =
          await _fetchAvailableContracts(activeSymbol);
      emit(AvailableContractsLoaded(contracts: contracts));
    } on ContractsForSymbolException catch (e) {
      emit(AvailableContractsError(message: e.message));
    }
  }
}
