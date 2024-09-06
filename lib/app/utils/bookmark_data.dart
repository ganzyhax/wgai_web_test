import 'package:hive/hive.dart';

class BookmarkData {
  static final BookmarkData _instance = BookmarkData._internal();

  late Box _box;

  BookmarkData._internal();

  factory BookmarkData() {
    return _instance;
  }

  Future<void> init() async {
    _box = await Hive.openBox('dataManager');
  }

  /// Add an item to a specific list
  Future<void> addItem(String listName, String item) async {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));
    if (!list.contains(item)) {
      list.add(item);
      await _box.put(listName, list);
    }
  }

  /// Remove an item from a specific list
  Future<void> removeItem(String listName, String item) async {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));
    list.remove(item);
    await _box.put(listName, list);
  }

  /// Check if an item exists in a specific list
  bool containsItem(String listName, String item) {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));
    return list.contains(item);
  }

  /// Retrieve all items from a specific list
  List<String> getItems(String listName) {
    return List<String>.from(_box.get(listName, defaultValue: []));
  }

  /// Clear all items from a specific list
  Future<void> clearList(String listName) async {
    await _box.put(listName, []);
  }
}
