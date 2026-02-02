import 'package:url_launcher/url_launcher.dart';

class SmartDetection {
  // Regular expressions for detection
  static final RegExp _phoneRegex = RegExp(
    r'(\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}',
  );
  
  static final RegExp _emailRegex = RegExp(
    r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
  );
  
  static final RegExp _urlRegex = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  );
  
  static final RegExp _hashtagRegex = RegExp(
    r'#[a-zA-Z0-9_]+',
  );

  // Detection methods
  static List<String> detectPhoneNumbers(String text) {
    return _phoneRegex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  static List<String> detectEmails(String text) {
    return _emailRegex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  static List<String> detectUrls(String text) {
    return _urlRegex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  static List<String> detectHashtags(String text) {
    return _hashtagRegex
        .allMatches(text)
        .map((match) => match.group(0)!)
        .toList();
  }

  // Action methods
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  static Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  static Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Extract all smart elements from text
  static Map<String, List<String>> extractAllSmartElements(String text) {
    return {
      'phones': detectPhoneNumbers(text),
      'emails': detectEmails(text),
      'urls': detectUrls(text),
      'hashtags': detectHashtags(text),
    };
  }
}
