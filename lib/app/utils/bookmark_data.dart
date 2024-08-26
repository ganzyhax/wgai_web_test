import 'package:hive/hive.dart';

class BookmarkManager {
  static final BookmarkManager _instance = BookmarkManager._internal();

  late Box _box;

  BookmarkManager._internal();

  factory BookmarkManager() {
    return _instance;
  }

  Future<void> init() async {
    _box = await Hive.openBox('bookmarks');
  }

  /// Add a bookmark by its ID
  Future<void> addBookmark(String id) async {
    final List<String> bookmarks =
        List<String>.from(_box.get('bookmarks', defaultValue: []));
    if (!bookmarks.contains(id)) {
      bookmarks.add(id);
      await _box.put('bookmarks', bookmarks);
    }
  }

  /// Remove a bookmark by its ID
  Future<void> removeBookmark(String id) async {
    final List<String> bookmarks =
        List<String>.from(_box.get('bookmarks', defaultValue: []));
    bookmarks.remove(id);
    await _box.put('bookmarks', bookmarks);
  }

  /// Check if a particular ID is bookmarked
  bool isBookmarked(String id) {
    final List<String> bookmarks =
        List<String>.from(_box.get('bookmarks', defaultValue: []));
    return bookmarks.contains(id);
  }

  /// Retrieve all bookmarked IDs
  List<String> getBookmarks() {
    return List<String>.from(_box.get('bookmarks', defaultValue: []));
  }

  /// Clear all bookmarks
  Future<void> clearBookmarks() async {
    await _box.put('bookmarks', []);
  }
}
