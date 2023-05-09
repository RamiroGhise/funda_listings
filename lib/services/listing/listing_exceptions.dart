
/// Custom [BadRequestListingException] to have more control over the
/// [Exception] and to create better user experience by customizing error texts.
class BadRequestListingException implements Exception {
  final String text;

  BadRequestListingException(this.text);
}