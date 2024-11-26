import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'colleges_event.dart';
part 'colleges_state.dart';

class CollegesBloc extends Bloc<CollegesEvent, CollegesState> {
  CollegesBloc() : super(CollegesInitial()) {
    var colleges;
    var specialities;
    var filteredColleges;
    on<CollegesEvent>((event, emit) async {
      if (event is CollegesLoad) {
        colleges = await ApiClient.get('api/resources/kazColleges');
        colleges = colleges['data']['data'];
        specialities =
            await ApiClient.get('api/resources/kazCollegeSpecialties');
        filteredColleges = colleges;
        emit(CollegesLoaded(
            colleges: colleges,
            filteredColleges: filteredColleges,
            specialities: specialities['data']['data']));
      }
      if (event is CollegesLoadByFilters) {
        try {
          var sortedColleges = [];

          for (var collegeData in colleges) {
            bool matchesRegion = event.regionId == null ||
                collegeData['regionId'] == event.regionId;
            bool matchesDormitory = event.hasDormitory == null ||
                collegeData['hasDormitory'] == event.hasDormitory;

            bool matchesSpecialties = true;
            if (event.specialities != null && event.specialities!.isNotEmpty) {
              // Get the selected specialties' codes
              List<String?> selectedSpecialtiesCodes =
                  event.specialities!.map((s) => s.code).toList();

              // Get the university's specialties' codes
              List<String?> universitySpecialtyCodes =
                  collegeData['specialties']?.map((s) => s.code).toList() ?? [];

              // Ensure there's a match between selected and university specialties
              matchesSpecialties = selectedSpecialtiesCodes.any(
                  (selectedCode) =>
                      universitySpecialtyCodes.contains(selectedCode));
            }

            if (matchesRegion && matchesSpecialties) {
              sortedColleges.add(collegeData);
            }
          }

          if (sortedColleges.isNotEmpty) {
            filteredColleges = sortedColleges;
            emit(CollegesLoaded(
                specialities: specialities,
                colleges: colleges,
                filteredColleges: filteredColleges));
          } else {
            filteredColleges = sortedColleges;
            emit(CollegesLoaded(
                specialities: specialities,
                colleges: colleges,
                filteredColleges: filteredColleges));
          }
        } catch (e) {
          log(e.toString());
        }
      }
      if (event is CollegesResetFilter) {
        filteredColleges = colleges;
        emit(CollegesLoaded(
            specialities: specialities,
            colleges: colleges,
            filteredColleges: filteredColleges));
      }
    });
  }
}
