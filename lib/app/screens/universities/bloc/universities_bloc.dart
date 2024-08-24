import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/network/specialities_network.dart';

part 'universities_event.dart';
part 'universities_state.dart';

class UniversitiesBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  UniversitiesBloc() : super(UniversitiesInitial()) {
    on<LoadUniversities>(_onFetchUniversities);
  }

  Future<void> _onFetchUniversities(
      LoadUniversities event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());

    try {
      final KazUniversity? uniModel =
          await UniversitiesNetwork().fetchSpecies();
      if (uniModel != null && uniModel.universities != null) {
        emit(UniversitiesLoaded(uniModel.universities));
      } else {
        emit(UniversitiesError('Kaz universities Data not loaded'));
      }
    } catch (e) {
      emit(UniversitiesError('Failed to fetch universities'));
    }
  }
}
