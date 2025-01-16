
import 'package:intl/intl.dart';

class RFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // number format:  98583987
    if (phoneNumber.length == 8) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)})';
    }
    return phoneNumber;
  }

  static internationalFormatPhoneNumber(String phoneNumber) {
    //removing any non-digital character from pn
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // extract the country code from digit only
    String countryCode = '+${ digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    //ADD the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write('');
      }
      i = end;
    }
  }
}

