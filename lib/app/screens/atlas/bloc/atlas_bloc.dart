import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';
import 'package:wg_app/app/utils/local_utils.dart';

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
          // Fetch occupations data
          occupations = await ApiClient.get(
            'api/occupations/clusters/' + event.clusterId,
          );

          // Get the selected language
          String localLang = await LocalUtils.getLanguage();

          // Access and sort occupations by the localized title
          final occupationsData =
              occupations['data']['occupations'] as List<dynamic>;
          occupationsData.sort((a, b) {
            // Get titles based on the selected language
            final titleA = (a['title'] as Map<String, dynamic>?)?[localLang]
                    ?.toLowerCase() ??
                '';
            final titleB = (b['title'] as Map<String, dynamic>?)?[localLang]
                    ?.toLowerCase() ??
                '';

            return titleA.compareTo(titleB);
          });

          // Emit the sorted occupations
          emit(AtlasLoaded(
            professions: occupationsData,
            clusters: clusters['data']['clusters'],
          ));
        } catch (e) {
          emit(SpecialitiesError('Failed to fetch atlas'));
        }
      }
    });
  }
}
