import 'package:deriv_go/features/home_screen/states/available_contracts/available_contracts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/contract/models/available_contract_model.dart';

/// for contract list
class AvailableContractsList extends StatelessWidget {
  /// initializer
  const AvailableContractsList({Key? key}) : super(key: key);

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
                  final AvailableContractsLoaded thisState =
                      state as AvailableContractsLoaded;
                  final List<AvailableContractModel?>? availableContracts =
                      thisState.contracts?.availableContracts;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: availableContracts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final AvailableContractModel? contract =
                          availableContracts?[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Category: ${contract?.contractCategory}',
                            ),
                            Text('Name: ${contract?.exchangeName}'),
                            Text('Sub market: ${contract?.submarket}'),
                            Text('Market:  ${contract?.market}'),
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
