part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState{}

class DashboardLoaded extends DashboardState{
  List<DataGridResponse> mocklistdata;

  DashboardLoaded(this.mocklistdata);
}

class DashboardLoadedError extends DashboardState{
  String error;

  DashboardLoadedError(this.error);
}
