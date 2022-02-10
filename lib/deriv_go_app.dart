import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/state/connection/connection_cubit.dart'
    as conn_cubit;

import 'features/home_screen/presentation/pages/home.dart';

///Application starting point
class DerivGoApp extends StatefulWidget {
  ///Constructor
  const DerivGoApp({Key? key}) : super(key: key);

  @override
  _DerivGoAppState createState() => _DerivGoAppState();
}

class _DerivGoAppState extends State<DerivGoApp> {
  late conn_cubit.ConnectionCubit _connectionCubit;

  // late BaseAPI? api;

  @override
  void initState() {
    super.initState();

    /*APIInitializer().initialize();
    api = Injector.getInjector().get<BaseAPI>();*/

    final ConnectionInformation connectionInfo = ConnectionInformation(
      appId: '1089',
      brand: 'binary',
      endpoint: 'frontend.binaryws.com',
    );

    _connectionCubit = conn_cubit.ConnectionCubit(connectionInfo);

    /*api?.connect(
      connectionInfo,
      onDone: (_) {
        print('Connection done');
      },
      onOpen: (_) {
        print('Connection open');
      },
      onError: (_) {
        print('Connection error');
      },
    );*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider<conn_cubit.ConnectionCubit>.value(
          value: _connectionCubit,
          child: BlocBuilder<conn_cubit.ConnectionCubit,
              conn_cubit.ConnectionState>(
            builder: (BuildContext context, dynamic state) {
              switch (state.runtimeType) {
                case conn_cubit.ConnectionConnectedState:
                  return const HomeScreen();
                case conn_cubit.ConnectionConnectingState:
                  return _buildCenterText('Connecting...');
                case conn_cubit.ConnectionErrorState:
                  return _buildCenterText('Connection Error\n${state.error}');
                case conn_cubit.ConnectionDisconnectedState:
                  return _buildCenterText(
                    'Connection is down, trying to reconnect...',
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      );

  Widget _buildCenterText(String text) => Center(
        child: Text(text),
      );
}
