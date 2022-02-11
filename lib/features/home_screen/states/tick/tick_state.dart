part of 'tick_cubit.dart';

///
@immutable
abstract class TickState {
  ///
  const TickState();
}

/// TicksLoading
class TicksLoading extends TickState {
  @override
  String toString() => 'TicksLoading...';
}

/// TicksError
class TickError extends TickState {
  /// Initializes
  const TickError({this.message});

  /// Error message
  final String? message;

  @override
  String toString() => 'TicksError';
}

/// TicksLoaded
class TicksLoaded extends TickState {
  /// Initializes
  const TicksLoaded({this.tick});

  /// Loaded tick
  final Tick? tick;

  @override
  String toString() => 'Tick $tick loaded';
}

///
class YieldTick extends TickState {
  /// Initializes
  const YieldTick({this.tick});

  /// Loaded tick
  final Tick? tick;

  @override
  String toString() => 'YieldTicks $tick';
}
