import 'package:nylo_framework/nylo_framework.dart';

class Place extends Model {
  static StorageKey key = "place";

  final String id, slug, name;
  final String? description, thumbnailUrl;
  final bool? isVirtual;
  final double lat, lng;

  Place(this.id, this.slug, this.name, this.description, this.isVirtual,
      this.thumbnailUrl, this.lat, this.lng)
      : super(key: key);

  Place.fromJson(data)
      : id = data['id'],
        slug = data['slug'],
        name = data['name'],
        description = data['description'] ?? '',
        isVirtual = (data['is_virtual'] ?? false) as bool,
        thumbnailUrl = data['thumbnail_url'] ?? '',
        lat = data['lat'] ?? 0.0,
        lng = data['lng'] ?? 0.0,
        super(key: key);

  @override
  toJson() => {
        'id': id,
        'slug': slug,
        'name': name,
        'description': description,
        'is_virtual': isVirtual,
        'thumbnail_url': thumbnailUrl,
        'lat': lat,
        'lng': lng,
      };
}
