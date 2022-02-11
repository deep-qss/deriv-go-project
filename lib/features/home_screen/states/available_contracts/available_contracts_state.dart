part of 'available_contracts_cubit.dart';

/// available contracts state
@immutable
abstract class AvailableContractsState {
  ///constructor
  const AvailableContractsState();
}

/// contracts loading state
class AvailableContractsLoading extends AvailableContractsState {
  @override
  String toString() => 'AvailableContractsLoading...';
}

/// contracts loaded state
class AvailableContractsLoaded extends AvailableContractsState {
  /// Initializes
  AvailableContractsLoaded({
    this.contracts,
    AvailableContractModel? selectedContract,
  }) : _selectedContract =
            selectedContract ?? contracts?.availableContracts?.first;

  /// variable declaration state
  final ContractsForSymbol? contracts;
  final AvailableContractModel? _selectedContract;

  /// Selected Contract
  AvailableContractModel? get selectedContract => _selectedContract;

  @override
  String toString() =>
      'AvailableContractsLoaded ${contracts!.availableContracts!.length}'
      ' contracts';
}

///contracts error state
class AvailableContractsError extends AvailableContractsState {
  /// Initializes
  const AvailableContractsError({this.message});

  /// Error message
  final String? message;

  @override
  String toString() => 'AvailableContractsError';
}
