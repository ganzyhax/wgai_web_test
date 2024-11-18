import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'atlas_event.dart';
part 'atlas_state.dart';

class AtlasBloc extends Bloc<AtlasEvent, AtlasState> {
  AtlasBloc() : super(AtlasInitial()) {
    var clusters;
    var occupations;
    on<AtlasEvent>((event, emit) async {
      if (event is AtlasLoad) {
        emit(AtlasLoading());

        try {
          clusters = await ApiClient.get('api/occupations/clusters');

          emit(AtlasLoaded(
              professions: null, clusters: clusters['data']['clusters']));
        } catch (e) {
          emit(SpecialitiesError('Failed to fetch atlas'));
        }
      }
      if (event is AtlasLoadByClusterId) {
        emit(AtlasLoading());
        try {
          occupations = await ApiClient.get(
              'api/occupations/clusters/' + event.clusterId);
          emit(AtlasLoaded(
              professions: occupations['data']['occupations'],
              clusters: clusters['data']['clusters']));
        } catch (e) {
          emit(SpecialitiesError('Failed to fetch atlas'));
        }
      }
    });
  }
}
