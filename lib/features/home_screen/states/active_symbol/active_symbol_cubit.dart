import 'package:bloc/bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/exceptions/active_symbols_exception.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:meta/meta.dart';

part 'active_symbol_state.dart';

///
class ActiveSymbolCubit extends Cubit<ActiveSymbolState> {
  /// ActiveSymbolCubit Initializer
  ActiveSymbolCubit() : super(ActiveSymbolLoading());

  Future<List<ActiveSymbol>> _fetchActiveSymbols() async =>
      ActiveSymbol.fetchActiveSymbols(const ActiveSymbolsRequest(
        activeSymbols: 'brief',
        productType: 'basic',
      ));

  ///Load all active symbols
  Future<void> loadActiveSymbols() async {
    try {
      final List<ActiveSymbol> symbols = await _fetchActiveSymbols();
      print('Active symbols are loaded now');
      emit(ActiveSymbolLoaded(activeSymbols: symbols));
    } on ActiveSymbolsException catch (error) {
      emit(ActiveSymbolError(error.message));
    }
  }

  ///Change selected symbol
  ///[index] from the list of active symbols
  void selectSymbol(int index) {
    if (state is ActiveSymbolLoaded) {
      final ActiveSymbolLoaded loadedState = state as ActiveSymbolLoaded;
      emit(ActiveSymbolLoaded(
        activeSymbols: loadedState.activeSymbols,
        selectedSymbol: loadedState.activeSymbols![index],
      ));
    } else {
      emit(ActiveSymbolLoading());
    }
  }
}
