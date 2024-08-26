import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    final data = [];

    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoad) {
        emit(ProfileLoaded(data: data));
      }
      if (event is ProfileChangeUserData) {
        var req = await ApiClient.post('api/user/updateUserProfile', {
          "firstName": event.name,
          "lastName": event.surname,
        });
        if (req['success']) {
          emit(ProfileUpdatedSuccess());
          emit(ProfileLoaded(data: data));
        }
      }
    });
  }
}
