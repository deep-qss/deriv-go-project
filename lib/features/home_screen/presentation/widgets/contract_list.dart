import 'package:deriv_go/features/home_screen/states/available_contracts/available_contracts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/contracts_for/contracts_for_symbol.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

///
class AvailableContractList extends StatefulWidget {
  ///
  const AvailableContractList({
    Key? key,
    this.contractsForSymbol,
  }) : super(key: key);

  ///  for selected contracts
  final ContractsForSymbol? contractsForSymbol;

  @override
  State<AvailableContractList> createState() => _AvailableContractListState();
}

class _AvailableContractListState extends State<AvailableContractList> {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(10), child: Text('Available Contracts')),
          BlocBuilder<AvailableContractsCubit, AvailableContractsState>(
            builder: (BuildContext context, AvailableContractsState state) {
              switch (state.runtimeType) {
                case AvailableContractsLoading:
                  return Container();
                case AvailableContractsLoaded:
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        widget.contractsForSymbol?.availableContracts?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AvailableContractModel? contract =
                          widget.contractsForSymbol?.availableContracts![index];
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Category: ${contract?.contractCategory}',
                            ),
                            Text('Name: ${contract?.exchangeName}'),
                            Text('Sub market:${contract?.submarket}'),
                            Text('Market : ${contract?.market}'),
                          ],
                        ),
                      );
                    },
                  );
                default:
                  return Container();
              }
            },
          ),
        ],
      );
}
