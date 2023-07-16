// import 'dart:io';

// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class CustomCacheManager extends BaseCacheManager {
//   static const String customCacheFolder = 'custom_cache_folder';

//   CustomCacheManager() : super(customCacheFolder);

//   @override
//   Future<String> getFilePath(String url, {String key}) async {
//     final directory = await getTemporaryDirectory();

//     // Specify the folder path for the cache item
//     final folderPath = '${directory.path}/$customCacheFolder';

//     // Create the folder if it doesn't exist
//     await Directory(folderPath).create(recursive: true);

//     // Get the file path by combining the folder path and the key
//     final filePath = p.join(folderPath, key ?? url);

//     return filePath;
//   }
// }