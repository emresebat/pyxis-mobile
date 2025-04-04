import 'package:nylo_framework/nylo_framework.dart';

class CreatePlaceRequest extends Model {
  static StorageKey key = "add_place_request";

  final String? slug, name, description, thumbnailUrl;
  final double lat, lng;

  CreatePlaceRequest(this.slug, this.name, this.description, this.thumbnailUrl,
      this.lat, this.lng)
      : super(key: key);

  CreatePlaceRequest.fromJson(data)
      : slug = data['slug'],
        name = data['name'],
        description = data['description'],
        thumbnailUrl = data['thumbnail_url'] ?? '',
        lat = data['lat'] ?? 0.0,
        lng = data['lng'] ?? 0.0,
        super(key: key) {}

  @override
  toJson() => {
        'slug': slug,
        'name': name,
        'description': description,
        'thumbnail_url': thumbnailUrl,
        'lat': lat,
        'lng': lng,
      };
}
