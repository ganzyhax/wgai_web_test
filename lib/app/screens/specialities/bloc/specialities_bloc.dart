import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/universities/model/universities_model.dart';

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
            codeNumber: '01',
            title: 'University A',
            firstDescription: 'Description A1',
            secondDescription: 'Description A2'),
        SpecialResources(
            codeNumber: '02',
            title: 'University B',
            firstDescription: 'Description B1',
            secondDescription: 'Description B2'),
      ];

      emit(SpecialitiesLoaded(universities));
    } catch (e) {
      emit(SpecialitiesError('Failed to fetch universities'));
    }
  }
}
