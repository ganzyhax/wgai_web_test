import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/components/news_card.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              CustomSnackbar()
                  .showCustomSnackbar(context, state.message, false);
            }
          },
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoaded) {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                          data: state.data[index], localLang: state.localLang);
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
