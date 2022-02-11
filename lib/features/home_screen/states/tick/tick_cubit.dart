import 'package:bloc/bloc.dart';
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/exceptions/tick_exception.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:flutter_deriv_api/basic_api/generated/ticks_send.dart';
import 'package:meta/meta.dart';

part 'tick_state.dart';

/// Tick Cubit
class TickCubit extends Cubit<TickState> {
  /// Initializer
  TickCubit(ActiveSymbolCubit activeSymbolCubit) : super(TicksLoading()) {
    activeSymbolCubit.stream
        .listen((ActiveSymbolState activeSymbolsState) async {
      if (activeSymbolsState is ActiveSymbolLoaded) {
        if (activeSymbolsState.selectedSymbol != null) {
          await subscribeTicks(activeSymbolsState.selectedSymbol!);
        }
      }
    });
  }

  /// for subscribe tick
  /// [symbol] to update ticks for specified symbol
  Future<void> subscribeTicks(ActiveSymbol symbol) async {
    emit(TicksLoading());

    await _unsubscribeTick();

    _subscribeTick(symbol)
        .handleError((dynamic error) => error is TickException
            ? emit(TickError(message: error.message))
            : emit(TickError(message: error.toString())))
        .listen((Tick? tick) => emit(TicksLoaded(tick: tick)));
  }

  Stream<Tick?> _subscribeTick(ActiveSymbol selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol.symbol),
      );

  Future<ForgetAll> _unsubscribeTick() => Tick.unsubscribeAllTicks();

  @override
  Future<void> close() async {
    await _unsubscribeTick();
    await super.close();
  }
}
