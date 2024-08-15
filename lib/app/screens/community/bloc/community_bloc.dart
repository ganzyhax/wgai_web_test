import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  int selectedTabIndex = 0;
  CommunityBloc() : super(CommunityInitial()) {
    on<CommunityEvent>((event, emit) {
      if (event is CommunityLoad) {
        emit(CommunityLoaded(selectedTabIndex: selectedTabIndex));
      }
      if (event is CommunitySelectTabIndex) {
        selectedTabIndex = event.selectedTabIndex;
        emit(CommunityLoaded(selectedTabIndex: selectedTabIndex));
      }
    });
  }
}