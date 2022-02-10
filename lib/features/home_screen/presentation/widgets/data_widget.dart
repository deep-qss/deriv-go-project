/*
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:deriv_go/features/home_screen/states/tick/tick_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
class DataWidget extends StatefulWidget {
  ///
  const DataWidget({Key? key}) : super(key: key);

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  double? _lastTickValue = 0;
  ActiveSymbolCubit? activeSymbolCubit;
  TickCubit? tickCubit;
  @override
  void initState() {
    super.initState();
    //final activeSymbolCubit = context.bloc<ActiveSymbolCubit>();
    tickCubit = TickCubit(activeSymbolCubit!);
  }

  ///

  @override
  Widget build(BuildContext context) => Container(
        height: 200,
        child: Card(
            child: Column(
          children: <Widget>[
            BlocConsumer<ActiveSymbolCubit, ActiveSymbolState>(
              listener: (BuildContext context, ActiveSymbolState state) {},
              builder: (BuildContext context, ActiveSymbolState state) {
                switch (state.runtimeType) {
                  case ActiveSymbolLoading:
                    return const Center();
                  case ActiveSymbolLoaded:
                    final ActiveSymbolLoaded thisState =
                        state as ActiveSymbolLoaded;
                    return BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                      builder:
                          (BuildContext context, ActiveSymbolState state) =>
                              Text(
                        'Symbol Name : ${thisState.selectedSymbol?.symbol}',
                      ),
                    );
                  default:
                    return Container();
                }
              },
            ),
            BlocConsumer<TickCubit, TickState>(
              listener: (context, state) {},
              builder: (BuildContext context, TickState state) {
                if (state is TicksLoaded) {
                  final Color tickColor = state.tick!.ask! > _lastTickValue!
                      ? Colors.green
                      : state.tick!.ask == _lastTickValue
                          ? Colors.black
                          : Colors.red;

                  _lastTickValue = state.tick!.ask;
                  return Text(
                    '${state.tick?.ask?.toStringAsFixed(5)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: tickColor,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        )),
      );
}
*/
import 'package:deriv_go/features/home_screen/states/active_symbol/active_symbol_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
class DataWidget extends StatelessWidget {
  ///
  const DataWidget({Key? key}) : super(key: key);

  ///

  @override
  Widget build(BuildContext context) => Container(
        height: 200,
        child: Card(
          child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
              builder: (BuildContext context, ActiveSymbolState state) {
            switch (state.runtimeType) {
              case ActiveSymbolLoading:
                return const Center();
              case ActiveSymbolLoaded:
                final ActiveSymbolLoaded thisState =
                    state as ActiveSymbolLoaded;
                return BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                  builder: (BuildContext context, ActiveSymbolState state) =>
                      Column(
                    children: <Widget>[
                      Text('Symbol Name : ${thisState.selectedSymbol?.symbol}'),
                      Text(
                        'Price: ${thisState.selectedSymbol?.intradayIntervalMinutes}',
                      ),
                    ],
                  ),
                );
              default:
                return Container();
            }
          }),
        ),
      );
}
