class HistoryEntry {
  final String emotion;
  final String activity;
  final DateTime timestamp;
  final Map<String, dynamic>? activityData;
  final String? rating;

  HistoryEntry({
    required this.emotion,
    required this.activity,
    required this.timestamp,
    this.activityData,
    this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'emotion': emotion,
      'activity': activity,
      'timestamp': timestamp.toIso8601String(),
      'activityData': activityData,
      'rating': rating,
    };
  }

  static HistoryEntry fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? data;
    if (json['activityData'] != null) {
      data = Map<String, dynamic>.from(json['activityData']);
    }

    return HistoryEntry(
      emotion: json['emotion'],
      activity: json['activity'],
      timestamp: DateTime.parse(json['timestamp']),
      activityData: data,
      rating: json['rating'],
    );
  }
}