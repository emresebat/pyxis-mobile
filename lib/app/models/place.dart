import 'package:nylo_framework/nylo_framework.dart';

class Place extends Model {
  static StorageKey key = "place";

  final String slug;
  final String name;
  final String description;
  final bool isVirtual;

  Place(this.slug, this.name, this.description, this.isVirtual)
      : super(key: key);

  Place.fromJson(data)
      : slug = data['slug'],
        name = data['name'],
        description = data['description'],
        isVirtual = data['is_virtual'] as bool,
        super(key: key);

  @override
  toJson() => {
        'slug': slug,
        'name': name,
        'description': description,
        'is_virtual': isVirtual,
      };
}
