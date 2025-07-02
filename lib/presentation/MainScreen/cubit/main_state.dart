part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}
final class PageSwitched extends MainState {}
final class TaskTypeChanged extends MainState {}
final class TimePicked extends MainState {}
final class DatePicked extends MainState {}

final class ValueAdded extends MainState {}
final class ValueRead extends MainState {}
final class ValueDeleted extends MainState {}
final class AllValueDeleted extends MainState {}
final class IsStrikes extends MainState {}
final class ValueUpdated extends MainState {}
