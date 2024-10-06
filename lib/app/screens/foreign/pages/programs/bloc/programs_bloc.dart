import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  ProgramsBloc() : super(ProgramsInitial()) {
    var data;
    on<ProgramsEvent>((event, emit) async {
      if (event is ProgramsLoad) {
        data = await ApiClient.get('api/resources/foreign/programs');
        if (data['success']) {
          emit(ProgramsLoaded(data: data['data']));
        }
      }
    });
  }
}
