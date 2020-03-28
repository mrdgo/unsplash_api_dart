import 'package:unsplash_api_dart/models/photo_urls.dart';

class LightPhoto {
  String id;
  int width;
  int height;
  String description;
  PhotoUrls urls;

  LightPhoto({
    this.id,
    this.width,
    this.height,
    this.description,
    this.urls,
  });

  factory LightPhoto.fromMap(Map data) {
    return LightPhoto(
      id: data['id'],
      width: data['width'],
      height: data['height'],
      description: data['description'],
      urls: PhotoUrls.fromMap(data['urls']),
    );
  }
}
