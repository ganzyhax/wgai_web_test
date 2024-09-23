import 'dart:developer';

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

  Future<void> _onLoadUniversities(
      LoadUniversities event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());
    try {
      final KazUniversity? uniModel =
          await UniversitiesNetwork().fetchSpecies();
      if (uniModel != null && uniModel.universities != null) {
        emit(UniversitiesLoaded(
            universities: uniModel.universities,
            filteredUniversities: uniModel.universities));
      } else {
        emit(UniversitiesError('Kaz universities data not loaded'));
      }
    } catch (e) {
      emit(UniversitiesError('Failed to fetch universities'));
    }
  }

  Future<void> _onFetchUniversities(
      LoadbyFilters event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());
    try {
      List<Universities> sortedUniversities = [];

      final KazUniversity? uniModel =
          await UniversitiesNetwork().fetchSpecies();

      for (var universityData in uniModel!.universities!) {
        bool matchesRegion =
            event.regionId == null || universityData.regionId == event.regionId;
        bool matchesDormitory = event.hasDormitory == null ||
            universityData.hasDormitory == event.hasDormitory;
        bool matchesMilitaryDept = event.hasMilitaryDept == null ||
            universityData.hasMilitaryDept == event.hasMilitaryDept;

        bool matchesSpecialties = true;
        log(event.specialities.toString() + ' here is');
        if (event.specialities != null && event.specialities!.isNotEmpty) {
          // Get the selected specialties' codes
          List<String?> selectedSpecialtiesCodes =
              event.specialities!.map((s) => s.code).toList();

          // Get the university's specialties' codes
          List<String?> universitySpecialtyCodes =
              universityData.specialties?.map((s) => s.code).toList() ?? [];

          // Ensure there's a match between selected and university specialties
          matchesSpecialties = selectedSpecialtiesCodes.any((selectedCode) =>
              universitySpecialtyCodes.contains(selectedCode));
        }

        if (matchesRegion && matchesSpecialties) {
          sortedUniversities.add(universityData);
        }
      }

      if (sortedUniversities.isNotEmpty) {
        emit(UniversitiesLoaded(
            universities: uniModel.universities,
            filteredUniversities: sortedUniversities));
      } else {
        emit(UniversitiesLoaded(
            universities: uniModel.universities,
            filteredUniversities: sortedUniversities));
      }
    } catch (e) {
      emit(UniversitiesError(e.toString()));
    }
  }

  Future<void> _onResetFilters(
      ResetFilters event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesInitial());
    add(LoadUniversities());
  }
}
