import 'dart:convert';
import 'dart:developer';
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
  Future<void> addItem(String listName, Map<String, dynamic> item) async {
    print(item);
    // Retrieve the list from the Hive box, which should be a List<String> since we are storing JSON-encoded strings
    final List<dynamic> rawList = _box.get(listName, defaultValue: []);
    final List<String> list =
        List<String>.from(rawList.map((e) => e.toString()));

    // Convert the Map to a JSON string
    String jsonString = jsonEncode(item);

    // Check if an item with the same 'id' already exists in the JSON string
    if (!list.any((element) {
      final decodedItem = jsonDecode(element);
      return decodedItem['id'] == item['id'];
    })) {
      list.add(jsonString);
      await _box.put(listName, list);
    }
  }

  /// Retrieve all items from a specific list
  List<Map<String, dynamic>> getItems(String listName) {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));
    return list
        .map((item) => Map<String, dynamic>.from(jsonDecode(item)))
        .toList();
  }

  /// Remove an item from a specific list by 'id'
  Future<void> removeItem(String listName, String id) async {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));

    // Remove the item with the matching 'id'
    list.removeWhere((element) {
      final decodedItem = jsonDecode(element);
      return decodedItem['id'] == id;
    });

    await _box.put(listName, list);
  }

  /// Check if an item with the specific 'id' exists in a specific list
  bool containsItem(String listName, String id) {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));

    return list.any((element) {
      final decodedItem = jsonDecode(element);
      return decodedItem['id'] == id;
    });
  }

  String getDataType(String listName, String id) {
    final List<String> list =
        List<String>.from(_box.get(listName, defaultValue: []));
    String res = '';
    for (var i in list) {
      final decodedItem = jsonDecode(i);
      if (decodedItem['id'] == id) {
        res = decodedItem['data']['type'];
      }
    }
    return res;
  }

  /// Clear all items from a specific list
  Future<void> clearList(String listName) async {
    await _box.put(listName, []);
  }
}
