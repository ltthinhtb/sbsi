enum AccountEnums { normal, margin }

extension AccountExt on AccountEnums {
  get name {
    switch (this) {
      case AccountEnums.normal:
        return "Thường";
      case AccountEnums.margin:
        return "Margin";
    }
  }
}

enum EKYC_image { frontCard, backCard, face1, face2, face3, signature }

extension ImageExtension on EKYC_image {
  String get value {
    switch (this) {
      case EKYC_image.frontCard:
        return "anhMatTruoc";
      case EKYC_image.backCard:
        return "anhMatSau";
      case EKYC_image.face1:
        return "anhTime1";
      case EKYC_image.face2:
        return "anhTime2";
      case EKYC_image.face3:
        return "anhTime3";
      case EKYC_image.signature:
        return "chuKy";
    }
  }
}

class EKYCImage {
  final EKYC_image ekycImage;
  final List<int> bytes;

  EKYCImage(this.ekycImage, this.bytes);
}
