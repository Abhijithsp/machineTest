import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../repository/repository.dart';
import '../data_model/data_grid_response.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  Repository repository;
  DashboardCubit(this.repository) : super(DashboardInitial());
  void getMockData() async{
    emit(DashboardLoading());
    repository.getMockApi().then((value){
      emit(DashboardLoading());
      if(value is List<DataGridResponse>){
        emit(DashboardLoaded(value));
      }else{
        emit(DashboardLoadedError("failed to fetch data!!"));
      }
    });
  }
}
