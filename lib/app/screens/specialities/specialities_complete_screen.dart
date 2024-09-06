import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wg_app/app/utils/bookmark_data.dart';

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
    isBookmarked = BookmarkManager().isBookmarked(widget.speciesId);
    super.initState();
  }

  void toggleBookmark() async {
    if (isBookmarked) {
      await BookmarkManager().removeBookmark(widget.speciesId);
    } else {
      await BookmarkManager().addBookmark(widget.speciesId);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ВУЗ'),
          actions: [
            IconButton(
              onPressed: () {
                toggleBookmark();
                print('Id: ${widget.speciesId}');
              },
              icon: isBookmarked
                  ? SvgPicture.asset('assets/icons/bookmark.svg')
                  : PhosphorIcon(PhosphorIconsBold.bookmark),
            ),
          ],
        ),
        body: Container());
  }
}
