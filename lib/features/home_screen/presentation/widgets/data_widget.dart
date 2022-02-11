import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:deriv_go/features/home_screen/states/tick/tick_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// for symbol and its price
class DataWidget extends StatefulWidget {
  /// Initializes
  const DataWidget({required this.activeSymbolCubit, Key? key})
      : super(key: key);

  /// ActiveSymbolCubit
  final ActiveSymbolCubit activeSymbolCubit;

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  late TickCubit _tickCubit;
  double? _lastTickValue = 0;
  @override
  void initState() {
    super.initState();

    _tickCubit = TickCubit(widget.activeSymbolCubit);
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.blueGrey.shade100,
        child: Column(
          children: <Widget>[
            BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                builder: (BuildContext context, ActiveSymbolState state) {
              switch (state.runtimeType) {
                case ActiveSymbolLoading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ActiveSymbolLoaded:
                  final ActiveSymbolLoaded thisState =
                      state as ActiveSymbolLoaded;
                  return BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                    builder: (BuildContext context, ActiveSymbolState state) =>
                        Text(
                      'Symbol Name : ${thisState.selectedSymbol?.symbol}',
                    ),
                  );
                default:
                  return Container();
              }
            }),
            BlocProvider<TickCubit>.value(
              value: _tickCubit,
              child: BlocBuilder<TickCubit, TickState>(
                builder: (BuildContext context, TickState state) {
                  switch (state.runtimeType) {
                    case TickError:
                      return const Text('Tick not loaded!! Error Occurred!!');
                    case TicksLoading:
                      return Container(
                        height: 25,
                        width: 25,
                        child: const CircularProgressIndicator(),
                      );
                    case TicksLoaded:
                      final TicksLoaded thisState = state as TicksLoaded;
                      final Color tickColor = state.tick!.ask! > _lastTickValue!
                          ? Colors.green
                          : state.tick!.ask == _lastTickValue
                              ? Colors.black
                              : Colors.red;

                      _lastTickValue = state.tick!.ask;
                      return Text(
                        'Price: \$ ${thisState.tick?.ask?.toStringAsFixed(5) ?? 0}',
                        style: TextStyle(
                          color: tickColor,
                        ),
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      );
}
