part of 'fivedays_bloc.dart';

@immutable
sealed class FiveDaysEvent extends Equatable{}
final class FetchFiveDays extends FiveDaysEvent{

  @override
  List<Object?> get props => [];
}
final class FetchFiveDaysWithCity extends FiveDaysEvent{
  final String city;
  FetchFiveDaysWithCity(this.city);

  @override
  List<Object?> get props => [city];
}
