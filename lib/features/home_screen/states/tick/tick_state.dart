part of 'tick_cubit.dart';

/// tick state
@immutable
abstract class TickState {
  /// Initializes
  const TickState();
}

/// Ticks loading state
class TicksLoading extends TickState {
  @override
  String toString() => 'TicksLoading...';
}

/// Ticks Error state
class TickError extends TickState {
  /// Initializes
  const TickError({this.message});

  /// Error message
  final String? message;

  @override
  String toString() => 'TicksError';
}

/// Ticks Loaded state
class TicksLoaded extends TickState {
  /// Initializes
  const TicksLoaded({this.tick});

  /// Loaded tick
  final Tick? tick;

  @override
  String toString() => 'Tick $tick loaded';
}
