import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wg_app/app/screens/questionnaire/model/questionnaire_model.dart';
import 'package:wg_app/app/screens/questionnaire/network/questionnaire_network.dart';

part 'questionnaire_bloc_event.dart';
part 'questionnaire_bloc_state.dart';

class QuestionnaireBlocBloc
    extends Bloc<QuestionnaireBlocEvent, QuestionnaireBlocState> {
  QuestionnaireBlocBloc() : super(QuestionnaireBlocInitial()) {
    @override
    Stream<QuestionnaireBlocState> mapEventToState(
        QuestionnaireBlocEvent event) async* {
      if (event is LoadQuestions) {
        yield QuestionnaireLoadingState();
        try {
          List<QuestionnaireModel> questions =
              await QuestionnaireNetwork().fetchQuestions();
          yield QuestionnaireSuccessState(
            questions: questions,
            currentIndex: 0,
          );
        } catch (e) {
          yield QuestionnaireErrorState(
            "Failed to load quiz",
          );
        }
      } else if (event is AnswersQuestions) {
        if (state is QuestionnaireSuccessState) {
          final currentState = state as QuestionnaireSuccessState;

          if (currentState.currentIndex < currentState.questions.length - 1) {
            yield QuestionnaireSuccessState(
              questions: currentState.questions,
              currentIndex: currentState.currentIndex + 1,
            );
          } else {
            yield QuestionnaireCompletedState();
          }
        }
      }
    }
  }
}

class ProgressBloc extends Cubit<double> {
  ProgressBloc() : super(0.2);

  void updateProgress(double progress) {
    emit(progress);
  }
}
