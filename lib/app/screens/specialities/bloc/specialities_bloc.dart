import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/app/screens/specialities/network/specialities_network.dart';

part 'specialities_event.dart';
part 'specialities_state.dart';

class SpecialitiesBloc extends Bloc<SpecialitiesEvent, SpecialitiesState> {
  SpecialitiesBloc() : super(SpecialitiesInitial()) {
    on<LoadSpecialities>(_onFetchSpecialities);
  }

  Future<void> _onFetchSpecialities(
      LoadSpecialities event, Emitter<SpecialitiesState> emit) async {
    emit(SpecialitiesLoading());

    try {
      final KazSpecialties? specialtiesModel =
          await SpecialitiesNetwork().fetchSpecies();
      if (specialtiesModel != null && specialtiesModel.specialties != null) {
        emit(SpecialitiesLoaded(specialtiesModel.specialties));
      } else {
        emit(SpecialitiesError('Kaz universities Data not loaded'));
      }
    } catch (e) {
      emit(SpecialitiesError('Failed to fetch universities'));
    }
  }
}
