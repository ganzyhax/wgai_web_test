import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'consulation_request_event.dart';
part 'consulation_request_state.dart';

class ConsulationRequestBloc extends Bloc<ConsulationRequestEvent, ConsulationRequestState> {
  ConsulationRequestBloc() : super(ConsulationRequestInitial()) {
    on<ConsulationRequestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
