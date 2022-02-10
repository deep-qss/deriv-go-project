import 'package:bloc/bloc.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';
import 'package:flutter_deriv_api/api/common/forget/forget_all.dart';
import 'package:flutter_deriv_api/api/common/tick/tick.dart';
import 'package:meta/meta.dart';

part 'tick_state.dart';

///
class TickCubit extends Cubit<TickState> {
  ///
  TickCubit()
      : super(
            TicksLoading()); /*{
    activeSymbolCubit.stream
        .listen((ActiveSymbolState activeSymbolsState) async {
      if (activeSymbolsState is ActiveSymbolLoaded) {
        emit(SubscribeTicks(selectedSymbol: activeSymbolsState.selectedSymbol));
      }
    });
  }*/

  ///
  Future<void> transformEvents(
    Future<TickState> events,
    Future<TickState> transitionFn,
  ) async {
    await transformEvents(
      events.timeout(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  ///

  Future<void> loadTick(Tick tick) async {
    if (tick is TicksLoaded) {
      emit(TicksLoaded(tick: tick));
    }
  }

  /* Future<Tick> _subscribeTick(ActiveSymbol activeSymbol){
    var thisTick = Tick.subscribeTick(TicksRequest(ticks: activeSymbol.symbol));
    return thisTick;


  }*/

/*  ///
  Future<void> loadTick(
    Tick event,
  ) async {
    if (event is TicksLoading) {
      emit(TicksLoading());

      await _unsubscribeTick();

      */ /*_subscribeTick(event.selectedSymbol!)
          .handleError(
            (dynamic error) => error is TickException
                ? add(TickError(message: error.message))
                : add(
                    TickError(message: error.toString()),
                  ),
          )
          .listen((Tick? tick) => add(TicksLoaded(tick: tick)));*/ /*
    } else if (event is TicksLoaded) {
      emit(TicksLoaded(tick: event));
    } else if (event is TickError) {
      emit(TickError(message: event.toString()));
    }
  }*/
/*
  Future<Tick?> _subscribeTick(ActiveSymbol selectedSymbol) =>
      Tick.subscribeTick(
        TicksRequest(ticks: selectedSymbol.symbol),
      );*/

  Future<ForgetAll> _unsubscribeTick() => Tick.unsubscribeAllTicks();

  @override
  Future<void> close() async {
    await _unsubscribeTick();
    await super.close();
  }
}
