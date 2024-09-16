import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/specialities/model/kaz_specialities.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/network/specialities_network.dart';

part 'universities_event.dart';
part 'universities_state.dart';

class UniversitiesBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  UniversitiesBloc() : super(UniversitiesInitial()) {
    on<LoadUniversities>(_onLoadUniversities);
    on<LoadbyFilters>(_onFetchUniversities);
    on<ResetFilters>(_onResetFilters);
  }

  Future<void> _onLoadUniversities(LoadUniversities event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());
    try {
      final KazUniversity? uniModel = await UniversitiesNetwork().fetchSpecies();
      if (uniModel != null && uniModel.universities != null) {
        emit(UniversitiesLoaded(uniModel.universities));
      } else {
        emit(UniversitiesError('Kaz universities data not loaded'));
      }
    } catch (e) {
      emit(UniversitiesError('Failed to fetch universities'));
    }
  }

  Future<void> _onFetchUniversities(LoadbyFilters event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());
    try {
      final String url = 'api/resources/kazUniversities/${event.universityCode}';
      final response = await ApiClient.get(url);

      if (response['success']) {
        Universities university = Universities.fromJson(response['university']);

        if (event.regionId != null && university.regionId != event.regionId) {
          emit(UniversitiesError('University does not match the region filter.'));
          return;
        }

        if (event.hasDormitory != null && university.hasDormitory != event.hasDormitory) {
          emit(UniversitiesError('University does not match the dormitory filter.'));
          return;
        }

        if (event.hasMilitaryDept != null && university.hasMilitaryDept != event.hasMilitaryDept) {
          emit(UniversitiesError('University does not match the military department filter.'));
          return;
        }

        if (event.specialities != null && event.specialities!.isNotEmpty) {
          university.specialties = university.specialties?.where((spec) => event.specialities!.contains(spec.code)).toList();
          if (university.specialties!.isEmpty) {
            emit(UniversitiesError('No matching specialties found.'));
            return;
          }
        }

        emit(UniversitiesLoaded([university]));
      } else {
        emit(UniversitiesError('Failed to fetch the university by code'));
      }
    } catch (e) {
      emit(UniversitiesError('Failed to fetch university by code'));
    }
  }

  Future<void> _onResetFilters(ResetFilters event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesInitial());
    add(LoadUniversities());
  }
}
