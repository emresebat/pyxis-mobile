import 'package:nylo_framework/nylo_framework.dart';

class Place extends Model {
  static StorageKey key = "place";

  final String slug, name, description, thumbnailUrl;
  final bool isVirtual;

  Place(
      this.slug, this.name, this.description, this.isVirtual, this.thumbnailUrl)
      : super(key: key);

  Place.fromJson(data)
      : slug = data['slug'],
        name = data['name'],
        description = data['description'],
        isVirtual = data['is_virtual'] as bool,
        thumbnailUrl = data['thumbnail_url'] ?? '',
        super(key: key);

  @override
  toJson() => {
        'slug': slug,
        'name': name,
        'description': description,
        'is_virtual': isVirtual,
        'thumbnail_url': thumbnailUrl,
      };
}
