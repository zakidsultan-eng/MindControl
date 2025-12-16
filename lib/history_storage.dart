import 'package:supabase_flutter/supabase_flutter.dart';
import 'history_entry.dart';

class HistoryStorage {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> addEntry(HistoryEntry entry) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('history').insert({
      'user_id': userId,
      'emotion': entry.emotion,
      'activity': entry.activity,
      'timestamp': entry.timestamp.toIso8601String(),
      'activity_data': entry.activityData,
      'rating': entry.rating,
    });
  }

  Future<List<HistoryEntry>> getEntries() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase
        .from('history')
        .select()
        .eq('user_id', userId)
        .order('timestamp', ascending: false);

    List<HistoryEntry> entries = [];
    for (var item in response) {
      entries.add(HistoryEntry(
        emotion: item['emotion'],
        activity: item['activity'],
        timestamp: DateTime.parse(item['timestamp']),
        activityData: item['activity_data'] != null
            ? Map<String, dynamic>.from(item['activity_data'])
            : null,
        rating: item['rating'],
      ));
    }

    return entries;
  }
}