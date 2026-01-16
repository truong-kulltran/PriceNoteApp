import 'package:intl/intl.dart';

/// Utility class for formatting currencies
class CurrencyFormatter {
  CurrencyFormatter._();

  /// Format amount as currency with symbol
  static String format(double amount, {String currency = 'USD'}) {
    final formatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(currency),
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format amount with sign (+ or -)
  static String formatWithSign(double amount, {String currency = 'USD'}) {
    final sign = amount >= 0 ? '+' : '';
    return '$sign${format(amount, currency: currency)}';
  }

  /// Get currency symbol from code
  static String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'VND':
        return '₫';
      default:
        return currency;
    }
  }
}

/// Utility class for formatting dates
class DateFormatter {
  DateFormatter._();

  static final _dateFormat = DateFormat('MMM dd, yyyy');
  static final _timeFormat = DateFormat('HH:mm');
  static final _dateTimeFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final _shortDateFormat = DateFormat('MM/dd/yy');

  static String formatDate(DateTime date) => _dateFormat.format(date);
  static String formatTime(DateTime date) => _timeFormat.format(date);
  static String formatDateTime(DateTime date) => _dateTimeFormat.format(date);
  static String formatShortDate(DateTime date) => _shortDateFormat.format(date);

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return formatDate(date);
    }
  }
}
