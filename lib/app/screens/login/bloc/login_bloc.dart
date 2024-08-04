import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/api_utils.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    bool isLoading = false;
    on<LoginEvent>((event, emit) async {
      if (event is LoginLoad) {
        emit(LoginLoaded(isLoading: isLoading));
      }
      if (event is LoginLog) {
        isLoading = true;
        emit(LoginLoaded(isLoading: isLoading));

        bool isSucces = await AuthUtils.login(event.login, event.password);
        if (isSucces) {
          emit(LoginSuccess());
          isLoading = false;
        }
        emit(LoginLoaded(isLoading: isLoading));
      }
    });
  }
}
