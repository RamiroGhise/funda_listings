import 'dart:convert';
import 'package:funda_listings/constants/credentials.dart';
import 'package:funda_listings/services/listing/listing.dart';
import 'package:funda_listings/services/listing/listing_exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;

class ListingService {
  ListingService();

  Future<Listing> getListing(String listingId) async {
    final url = Uri.parse(
        'http://partnerapi.funda.nl/feeds/Aanbod.svc/json/detail/$key/koop/$listingId/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 400) {
        String message = response.reasonPhrase ?? 'Unknown';
        throw BadRequestListingException(message);
      } else {
        final Listing listing = Listing.fromJson(jsonDecode(response.body));
        return listing;
      }
    } catch(e) {
      devtools.log('caught ${e.toString()}');
      rethrow;
    }
  }
}