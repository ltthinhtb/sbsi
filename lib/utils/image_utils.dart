import 'dart:typed_data';
import 'package:image/image.dart';

class ImageUtils {
  static Uint8List cropImageUint8List(Uint8List image) {
    var imageDecode = decodeImage(image.toList())!;
    var imageCrop = copyCrop(imageDecode, (imageDecode.width * 0.03).round(), (imageDecode.height * 0.03).round(),
            imageDecode.width, (imageDecode.height * 2 / 3).round());
    return Uint8List.fromList(encodePng(imageCrop));
  }
}
