part of 'active_symbol_cubit.dart';

/// active symbol state
@immutable
abstract class ActiveSymbolState {
  /// Initializes
  const ActiveSymbolState();
}

///State when loading the active symbols
class ActiveSymbolLoading extends ActiveSymbolState {
  @override
  String toString() => 'ActiveSymbolsLoading...';
}

///Load the Active symbol
class ActiveSymbolLoaded extends ActiveSymbolState {
  /// Initializes
  ActiveSymbolLoaded({
    this.activeSymbols,
    ActiveSymbol? selectedSymbol,
  }) : _selectedSymbol = selectedSymbol ?? activeSymbols?.first;

  /// List of symbols
  final List<ActiveSymbol>? activeSymbols;

  final ActiveSymbol? _selectedSymbol;

  /// Selected symbol
  ActiveSymbol? get selectedSymbol => _selectedSymbol;

  @override
  String toString() => 'ActiveSymbolLoaded ${activeSymbols!.length} symbols';
}

///Active Symbol Error
class ActiveSymbolError extends ActiveSymbolState {
  /// Initializes
  const ActiveSymbolError(this.message);

  /// Error message
  final String? message;

  @override
  String toString() => 'ActiveSymbolsError';
}

///Select active symbol
class SelectActiveSymbol extends ActiveSymbolState {
  /// Initializes
  const SelectActiveSymbol({this.index});

  /// Index of selected symbol
  final int? index;

  @override
  String toString() => 'SelectActiveSymbol index: $index';
}
