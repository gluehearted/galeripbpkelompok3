import 'dart:convert';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageService {
  Future<String?> compressAndEncode(String imagePath) async {
    try {
      final file = File(imagePath);
      final bytes = await file.readAsBytes();

      // Compress image
      final compressedBytes = await FlutterImageCompress.compressWithList(
        bytes,
        minWidth: 1000,
        minHeight: 1000,
        quality: 55,
      );

      // Convert to base64
      final base64Image = base64Encode(compressedBytes);

      // Check size
      final sizeInKB = (base64Image.length * 3) / 4 / 1024;

      print('Ukuran gambar: ${sizeInKB.toStringAsFixed(2)} KB');

      if (sizeInKB > 900) {
        throw Exception(
          'Gambar terlalu besar (${sizeInKB.toStringAsFixed(0)} KB). Pilih gambar lebih kecil.',
        );
      }

      return 'data:image/jpeg;base64,$base64Image';
    } catch (e) {
      rethrow;
    }
  }
}
