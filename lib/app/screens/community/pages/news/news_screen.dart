import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/bloc/news_bloc.dart';
import 'package:wg_app/app/screens/community/pages/news/components/news_card.dart';
import 'package:wg_app/app/widgets/custom_snackbar.dart';

class NewsScreen extends StatefulWidget {
  final String? newsID; // Accept newsID as a parameter

  const NewsScreen({super.key, this.newsID});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
  }

  void _scrollToNewsItem(String newsID) {
    final newsBloc = context.read<NewsBloc>();
    final newsState = newsBloc.state;

    if (newsState is NewsLoaded) {
      final index = newsState.data.indexWhere((news) => news['_id'] == newsID);

      if (index != -1) {
        _scrollController.animateTo(
          (index == 0) ? 0 : index * 445.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {}
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController, // Attach ScrollController here
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<NewsBloc, NewsState>(
          listener: (context, state) {
            if (state is NewsError) {
              CustomSnackbar()
                  .showCustomSnackbar(context, state.message, false);
            }
            // Check if the state is NewsLoaded
            if (state is NewsLoaded) {
              // Scroll to the specific news item after loading
              if (widget.newsID != null) {
                _scrollToNewsItem(widget.newsID!);
              }
            }
          },
          child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoaded) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  controller: _scrollController, // Attach controller here too
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return NewsCard(
                      data: state.data[index],
                      localLang: context.locale.languageCode,
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
