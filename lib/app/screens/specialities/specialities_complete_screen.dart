import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/screens/specialities/bloc/specialities_bloc.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';
import 'package:wg_app/constants/app_hive_constants.dart';

class SpecialitiesCompleteScreen extends StatefulWidget {
  final String speciesId;
  const SpecialitiesCompleteScreen({super.key, required this.speciesId});

  @override
  State<SpecialitiesCompleteScreen> createState() =>
      SpecialitiesCompleteScreenState();
}

class SpecialitiesCompleteScreenState
    extends State<SpecialitiesCompleteScreen> {
  late bool isBookmarked;

  @override
  void initState() {
    isBookmarked = false;
    super.initState();
  }

  void toggleBookmark() async {
    if (isBookmarked) {
      await BookmarkData().removeItem('bookmarks', widget.speciesId);
    } else {
      await BookmarkData().addItem(
          'bookmarks', {'id': widget.speciesId, 'data': widget.speciesId});
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Специальность'),
        actions: [
          IconButton(
            onPressed: () {
              toggleBookmark();
              print('Id: ${widget.speciesId}');
            },
            icon: isBookmarked
                ? SvgPicture.asset('assets/icons/bookmark.svg')
                : SvgPicture.asset('assets/icons/bookmark-open.svg'),
          ),
        ],
      ),
      body: BlocBuilder<SpecialitiesBloc, SpecialitiesState>(
        builder: (context, state) {
          if (state is SpecialitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SpecialitiesLoaded) {
            return Container();
          } else if (state is SpecialitiesError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
