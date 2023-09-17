import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../repository/repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  Repository repository;
  DetailsCubit(this.repository) : super(DetailsInitial());
}
