class BadRequestListingException implements Exception {
  final String text;

  BadRequestListingException(this.text);
}