import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/universities/model/universities_model.dart';

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

      emit(UniversitiesLoaded(universities));
    } catch (e) {
      emit(UniversitiesError('Failed to fetch universities'));
    }
  }
}
