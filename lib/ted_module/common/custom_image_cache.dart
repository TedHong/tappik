import 'package:flutter/cupertino.dart';

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    //print('createImageCache start');
    //WidgetsFlutterBinding.ensureInitialized();
    ImageCache imageCache = super.createImageCache();
    // Set your image cache size
    imageCache.maximumSizeBytes = 200 * 1024 * 1024; //200mb 이상->캐시클리어

    return imageCache;
  }
}
