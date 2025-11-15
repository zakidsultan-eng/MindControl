import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'history_entry.dart';

class HistoryStorage {
  static const String _historyKey = 'history_entries';

  Future<void> addEntry(HistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();

    List<HistoryEntry> entries = await getEntries();

    entries.add(entry);

    List<Map<String, dynamic>> jsonList = [];
    for (var i in entries) {
      jsonList.add(i.toJson());
    }

    String jsonString = jsonEncode(jsonList);
    await prefs.setString(_historyKey, jsonString);
  }

  Future<List<HistoryEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? entriesJson = prefs.getString(_historyKey);

    if (entriesJson == null) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(entriesJson);

    List<HistoryEntry> entries = [];
    for (var item in decoded) {
      entries.add(HistoryEntry.fromJson(item));
    }

    return entries.reversed.toList();
  }
}