import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/specialities/model/special_resources.dart';

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
      await Future.delayed(Duration(seconds: 1));
      final universities = [
        SpecialResources(
            codeNumber: 'B001',
            title: 'Педагогика и психология',
            firstDescription: 'Биология-География',
            secondDescription: 0),
        SpecialResources(
            codeNumber: 'B001',
            title: 'Педагогика и психология',
            firstDescription: 'Биология-География',
            secondDescription: 0),
      ];

      emit(SpecialitiesLoaded(universities));
    } catch (e) {
      emit(SpecialitiesError('Failed to fetch universities'));
    }
  }
}
