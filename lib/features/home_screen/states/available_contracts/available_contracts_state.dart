part of 'available_contracts_cubit.dart';

///AvailableContractsState
@immutable
abstract class AvailableContractsState {
  ///constructor
  const AvailableContractsState();
}

///Initial contracts
class AvailableContractsInitial extends AvailableContractsState {
  ///constructor
  const AvailableContractsInitial();
}

/// contracts loading
class AvailableContractsLoading extends AvailableContractsState {
  @override
  String toString() => 'AvailableContractsLoading...';
}

/// contracts loaded
class AvailableContractsLoaded extends AvailableContractsState {
  /// Initializes
  AvailableContractsLoaded({
    this.contracts,
    AvailableContractModel? selectedContract,
  }) : _selectedContract =
            selectedContract ?? contracts?.availableContracts?.first;

  /// variable declaration
  final ContractsForSymbol? contracts;
  final AvailableContractModel? _selectedContract;

  /// Selected Contract
  AvailableContractModel? get selectedContract => _selectedContract;

  @override
  String toString() =>
      'AvailableContractsLoaded ${contracts!.availableContracts!.length} contracts';
}

///contracts error
class AvailableContractsError extends AvailableContractsState {
  /// Initializes
  const AvailableContractsError({this.message});

  /// Error message
  final String? message;

  @override
  String toString() => 'AvailableContractsError';
}

/// SelectContract
class SelectContract extends AvailableContractsState {
  /// Initializes
  const SelectContract({this.index});

  /// Selected contract index
  final int? index;

  @override
  String toString() => 'SelectContract index: $index';
}

///Fetch Available Contracts
class FetchAvailableContracts extends AvailableContractsState {
  /// Initializes
  const FetchAvailableContracts({this.activeSymbol});

  /// Fetch contract for this symbol
  final ActiveSymbol? activeSymbol;

  @override
  String toString() => 'FetchAvailableContracts';
}
