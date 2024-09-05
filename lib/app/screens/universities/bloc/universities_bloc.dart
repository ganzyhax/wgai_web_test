import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/screens/universities/model/kaz_universities.dart';
import 'package:wg_app/app/screens/universities/network/specialities_network.dart';

part 'universities_event.dart';
part 'universities_state.dart';

class UniversitiesBloc extends Bloc<UniversitiesEvent, UniversitiesState> {
  String? _currentRegionId;
  List<Specialties>? _currentSpecialities;
  bool? _currentHasDormitory;
  bool? _currentHasMilitaryDept;
  UniversitiesBloc() : super(UniversitiesInitial()) {
    on<LoadUniversities>(_onFetchUniversities);
    on<LoadCities>(_onFetchRegions);
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

  Future<void> _onFetchRegions(
      LoadCities event, Emitter<UniversitiesState> emit) async {
    emit(UniversitiesLoading());
    try {
      final response = await ApiClient.get(
          'api/resources/kazUniversities?regionId=${event.regionId}');
      if (response['success']) {
        List<Universities> universities =
            (response['data']['universities'] as List)
                .map((data) => Universities.fromJson(data))
                .toList();
        emit(UniversitiesLoaded(universities));
      } else {
        emit(UniversitiesError('Failed to fetch universities by region'));
      }
    } catch (e) {
      emit(UniversitiesError('Failed to fetch universities'));
    }
  }

  Future<void> _onResetFilters(
      ResetFilters event, Emitter<UniversitiesState> emit) async {
    _currentRegionId = null;
    _currentSpecialities = null;
    _currentHasDormitory = null;
    _currentHasMilitaryDept = null;

    emit(FiltersApplied(
      regionId: _currentRegionId,
      specialities: _currentSpecialities,
      hasDormitory: _currentHasDormitory,
      hasMilitaryDept: _currentHasMilitaryDept,
    ));
  }
}
