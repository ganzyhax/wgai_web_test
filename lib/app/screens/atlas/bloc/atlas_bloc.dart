import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/atlas/model/professions_model.dart';
import 'package:wg_app/app/screens/atlas/network/atlas_network.dart';

part 'atlas_event.dart';
part 'atlas_state.dart';

class AtlasBloc extends Bloc<AtlasEvent, AtlasState> {
  AtlasBloc() : super(AtlasInitial()) {
    on<LoadAtlas>(_onFetchSpecialities);
  }

  Future<void> _onFetchSpecialities(
      LoadAtlas event, Emitter<AtlasState> emit) async {
    emit(AtlasLoading());

    try {
      final ProfessionsModel? professionsModel =
          await AtlasNetwork().fetchProfessions();
      if (professionsModel != null && professionsModel.professions != null) {
        emit(AtlasLoaded(professionsModel.professions));
      } else {
        emit(SpecialitiesError('Atlas Data not loaded'));
      }
    } catch (e) {
      emit(SpecialitiesError('Failed to fetch atlas'));
    }
  }
}
