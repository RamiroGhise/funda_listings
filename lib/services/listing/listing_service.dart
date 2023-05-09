import 'dart:convert';
import 'package:funda_listings/constants/credentials.dart';
import 'package:funda_listings/services/listing/listing.dart';
import 'package:funda_listings/services/listing/listing_exceptions.dart';
import 'package:http/http.dart' as http;

// use the log from dart:developer to better identify logs in console
import 'dart:developer' as devtools show log;

class ListingService {
  ListingService();

  /// Gets a listing from the internet using Funda's API.
  /// Takes as parameter a [String] listingId and returns a [Future]<[Listing]>.
  /// Used a custom error handling in case of known exceptions, such as
  /// 400 - Bad Request.
  Future<Listing> getListing(String listingId) async {
    final url = Uri.parse(
        'http://partnerapi.funda.nl/feeds/Aanbod.svc/json/detail/$key/koop/$listingId/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 400) {
        String message = response.reasonPhrase ?? 'Unknown';
        throw BadRequestListingException(message);
      } else {
        // create a [Listing] from a JSON
        final Listing listing = Listing.fromJson(jsonDecode(response.body));
        return listing;
      }
    } catch(e) {
      devtools.log('caught ${e.toString()}');
      rethrow;
    }
  }
}