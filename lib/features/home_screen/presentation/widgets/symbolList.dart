import 'package:flutter/material.dart';
import 'package:flutter_deriv_api/api/common/active_symbols/active_symbols.dart';

///
class ActiveSymbolList extends StatelessWidget {
  ///constructor
  const ActiveSymbolList({
    required this.activeSymbol,
    required this.selectSymbol,
    Key? key,
  }) : super(key: key);

  ///Callback for selecting a symbol
  final Function(int index) selectSymbol;

  ///List of active symbols
  final List<ActiveSymbol> activeSymbol;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: activeSymbol.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            leading: Text('${activeSymbol[index].symbol}'),
            onTap: () {
              selectSymbol(index);
              // context.read<ActiveSymbolCubit>().selectSymbol(index);
              Navigator.pop(context);
            },
          ),
        ),
      );
}
