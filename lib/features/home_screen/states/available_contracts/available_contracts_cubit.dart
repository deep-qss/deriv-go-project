import 'package:bloc/bloc.dart';
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/exceptions/contract_for_symbol_exception.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:meta/meta.dart';

part 'available_contracts_state.dart';

/// AvailableContractsCubit
class AvailableContractsCubit extends Cubit<AvailableContractsState> {
  ///initializer
  AvailableContractsCubit([ActiveSymbolCubit? activeSymbolCubit])
      : super(AvailableContractsLoading());

  /// fetch available contracts
  Future<ContractsForSymbol> fetchAvailableContracts(
          ActiveSymbol? activeSymbol) async =>
      await ContractsForSymbol.fetchContractsForSymbol(
          ContractsForRequest(contractsFor: activeSymbol?.symbol));

  /// load contracts list
  Future<void> loadContractsList(
      AvailableContractsState availableContractsState) async {
    if (availableContractsState is FetchAvailableContracts) {
      final ContractsForSymbol contracts =
          await fetchAvailableContracts(availableContractsState.activeSymbol);
      emit(AvailableContractsLoaded(contracts: contracts));
    } else {
      throw ContractsForSymbolException();
    }
  }

  /*AvailableContractsCubit(ActiveSymbolCubit? activeSymbolCubit)
      : super(AvailableContractsLoading()) {
    activeSymbolCubit?.stream.listen((ActiveSymbolState event) {
      if (event is ActiveSymbolLoaded) {
        emit(FetchAvailableContracts(activeSymbol: event.selectedSymbol));
      }
    });
  }

  Future<ContractsForSymbol?> _fetchAvailableContracts(
    ActiveSymbol? selectedSymbol,
  ) async =>
      ContractsForSymbol.fetchContractsForSymbol(
        ContractsForRequest(contractsFor: selectedSymbol?.symbol),
      );

  /// load contracts

  Future<void> loadAvailableContracts(
      AvailableContractsState availableContractsState) async {
    if (availableContractsState is FetchAvailableContracts) {
      try {
        final ContractsForSymbol? contracts = await _fetchAvailableContracts(
            availableContractsState.activeSymbol);

        print('contracts for symbol');

        emit(AvailableContractsLoaded(contracts: contracts));
      } on ContractsForSymbolException catch (error) {
        emit(AvailableContractsError(message: error.message));
      }
    }
  }*/

/*  ///
  Future<void> mapEventToState(
    AvailableContractsState availableContractsState,
  ) async {
    if (availableContractsState is FetchAvailableContracts) {
      emit(AvailableContractsLoading());

      try {
        final ContractsForSymbol? contracts = await _fetchAvailableContracts(
            availableContractsState.activeSymbol);

        emit(AvailableContractsLoaded(contracts: contracts));
      } on ContractsForSymbolException catch (error) {
        emit(AvailableContractsError(message: error.message));
      }
    } else if (availableContractsState is SelectContract) {
      if (state is AvailableContractsLoaded) {
        final AvailableContractsLoaded loadedState =
            state as AvailableContractsLoaded;

        emit(AvailableContractsLoaded(
          contracts: loadedState.contracts,
          selectedContract: loadedState.contracts?.availableContracts
              ?.elementAt(availableContractsState.index!.toInt()),
        ));
      } else {
        emit(AvailableContractsLoading());
        //add(_fetchAvailableContracts());
      }
    }
  }*/
}
