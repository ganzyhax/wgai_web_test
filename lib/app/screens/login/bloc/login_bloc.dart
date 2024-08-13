import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/api/auth_utils.dart';

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

        var attemp = await AuthUtils.login(event.login, event.password);

        if (attemp is bool) {
          emit(LoginSuccess());
          isLoading = false;
        } else {
          emit(LoginError(message: attemp));
        }
        emit(LoginLoaded(isLoading: isLoading));
      }
    });
  }
}
