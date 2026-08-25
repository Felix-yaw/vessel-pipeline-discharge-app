/// Small, dependency-free helpers for formatting timestamps used across the
/// operation screens. The app intentionally avoids intl to stay lightweight.
library;

const List<String> _months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

String _two(int value) => value.toString().padLeft(2, '0');

/// Formats a [DateTime] as a 12-hour clock time, e.g. "05:00 AM".
String formatClock(DateTime time) {
  final int hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final String period = time.hour < 12 ? 'AM' : 'PM';
  return '${_two(hour12)}:${_two(time.minute)} $period';
}

/// Formats a [DateTime] as "30 July 2026, 01:00 PM".
String formatDateTime(DateTime time) {
  return '${time.day} ${_months[time.month - 1]} ${time.year}, '
      '${formatClock(time)}';
}

/// Formats a [Duration] as HH:MM:SS, e.g. "00:03:45".
String formatElapsed(Duration duration) {
  final String hours = duration.inHours.toString().padLeft(2, '0');
  final String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$hours:$minutes:$seconds';
}
