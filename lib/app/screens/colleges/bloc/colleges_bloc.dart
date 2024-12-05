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
    String regionId = '';
    int currentPage = 1;

    on<CollegesEvent>((event, emit) async {
      if (event is CollegesLoad) {
        colleges = await ApiClient.get(
            'api/resources/kazColleges?page=' + currentPage.toString());
        log(colleges['data']['currentPage'].toString());
        log(colleges['data']['totalPages'].toString());
        log(colleges['data']['totalCount'].toString());
        int maxPage = int.parse(colleges['data']['totalPages'].toString());
        colleges = colleges['data']['data'];
        specialities =
            await ApiClient.get('api/resources/kazCollegeSpecialties');
        filteredColleges = colleges;
        emit(CollegesLoaded(
            colleges: colleges,
            filteredColleges: filteredColleges,
            maxPage: maxPage,
            currentPage: currentPage,
            specialities: specialities['data']['data']));
      }
      if (event is CollegesLoadByFilters) {
        log('LOadededede');
        regionId = event.regionId!;
        currentPage = 1;
        var res = await ApiClient.get('api/resources/kazColleges?page=' +
            currentPage.toString() +
            '&regionId=' +
            regionId);
        log('getting ' +
            ' api/resources/kazColleges?page=' +
            currentPage.toString() +
            '?regionId=' +
            regionId);

        log(res.toString());
        int maxPage = int.parse(res['data']['totalPages'].toString());
        colleges = res['data']['data'];

        filteredColleges = colleges;
        emit(CollegesLoaded(
            maxPage: maxPage,
            specialities: specialities,
            colleges: colleges,
            currentPage: currentPage,
            filteredColleges: filteredColleges));
      }
      if (event is CollegesResetFilter) {
        filteredColleges = colleges;
        emit(CollegesLoaded(
            maxPage: colleges['data']['totalPages'],
            specialities: specialities,
            colleges: colleges,
            currentPage: currentPage,
            filteredColleges: filteredColleges));
      }
      if (event is CollegesNextPage) {
        currentPage = currentPage + 1;
        var res = await ApiClient.get((regionId == '')
            ? 'api/resources/kazColleges?page=' + currentPage.toString()
            : 'api/resources/kazColleges?page=' +
                currentPage.toString() +
                '&regionId=' +
                regionId);
        int maxPage = int.parse(res['data']['totalPages'].toString());

        colleges.addAll(res['data']['data']);
        filteredColleges = colleges;
        emit(CollegesLoaded(
            maxPage: maxPage,
            specialities: specialities,
            colleges: colleges,
            currentPage: currentPage,
            filteredColleges: filteredColleges));
      }
    });
  }
}
