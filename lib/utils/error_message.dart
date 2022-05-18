import 'package:flutter/material.dart';
import 'package:sbsi/common/app_colors.dart';
import 'package:sbsi/model/order_data/inday_order.dart';

class MessageOrder {
  static const Map<String, String> errMsg = {
    "-6004": "Lệnh đã được xử lý, không được gửi lại.",
    "-6007": "Hủy lệnh không thành công.",
    "-6012": "Tài khoản không đủ sức mua.",
    "-6013": "Không đủ số dư chứng khoán.",
    "-6014": "Lệnh không được hủy.",
    "-6015": "Không được sửa lệnh này.",
    "-6016": "Loại chứng khoán không hợp lệ.",
    "-6017": "Tài Khoản đang chờ kích hoạt.",
    "-6019": "Khối lượng đặt không hợp lệ.",
    "-6020": "Không xác định được thị trường.",
    "-6021": "Giá không phù hợp.",
    "-6022": "Thị trường đóng cửa.",
    "-6023": "Loại lệnh không phù hợp.",
    "-6024": "Không được đặt loại lệnh phiên này.",
    "-6025": "Hệ thống chưa sẵn sàng đặt lệnh ngoài giờ.",
    "-6026": "Không được huỷ/sửa lệnh phiên này.",
    "-6027": "Không được đặt lệnh điều kiện.",
    "-6028": "Tài khoản không được mua - bán.",
    "-6029": "Tài khoản không được ủy quyền.",
    "-6030": "User không có quyền xem tài khoản.",
    "-6031": "Chứng khoán không hợp lệ.",
    "-6032": "Vượt qua tỷ lệ an toàn tài khoản.",
    "-6033": "Chứng khoán đáo hạn không được giao dịch.",
    "-6034": "Vượt qua khối lượng 1000 của phái sinh.",
    "-6035": "Sai giá trần/sàn.",
    "-6036": "Sai bước giá cho trái phiếu.",
    "-6037": "Không được đặt lệnh.",
    "-6038": "Vượt qua tổng vị thế tối đa.",
    "-6039": "Tài khoản mới mở, chưa được giao dịch.",
    "-6041": "Tài khoản hạn chế giao dịch.",
    "-6043": "Không được mua bán cùng phiên.",
    "-6045": "Chứng khoán hết room cho vay",
    "-6046": "Chứng khoán hết room nước ngoài",
    "-6047": "Hết hạn mức mã chứng khoán ",
    "-6048": "Không được sửa đồng thời giá và khối lượng",
    "-6666": "Hết hạn mức nguồn.",
    "-6667": "Hết hạn mức tài khoản.",
    "-6668": "Tài khoản hạn chế bán do QTRR.",
    "-6669": "Lệnh forcesell, KH không được thao tác.",
    "-6670": "Hết hạn mức tổng của nhóm.",
    "-6671": "Hết hạn mức công ty.",
    "-8001": "Không kết nối được với gateway.",
    "-8002": "Thị trường đóng của, không được đặt lệnh.",
    "-8003": "Không hủy/sửa phiên khớp lệnh định kỳ.",
    "-8004": "Lệnh đã khớp hết, không được hủy/sửa.",
    "-8005": "Không đủ điều kiện huỷ sửa.",
    "-8006": "Không dùng password cũ.",
    "-8007": "Password không hợp lệ.",
    "-8008": "Không có quyền truy cập từ IP ngoài.",
    "-8009": "TRADER HALT.",
    "-8010": "Hệ thống đang thi với HSX, KHÔNG ĐƯỢC ĐẶT LỆNH.",
    "-8011": "BrokerID đang bị chặn MUA.",
    "-8012": "BrokerID đang bị chặn BÁN.",
    "-8013": "BrokerID đang bị chặn giao dịch.",
    "-8014": "BrokerID bị chặn giao dịch thoả thuận.",
    "-8015": "BrokerID bị chặn giao dịch thoả thuận BÁN.",
    "-8016": "BrokerID bị chặn giao dịch thoả thuận MUA.",
    "-9998": "Lệnh chưa được confirm!",
    "-9999": "Không đủ điều kiện sửa.",
    "-9001": "Không được giao dịch mã chứng quyền trên TK margin",
    "-8": "Hệ thống chưa sẵn sàng nhận lệnh",
  };

  static const Map<int, String> errorOrder = {
    0: "Mã cổ phiếu rỗng",
    -1: "Giá không hợp lệ",
    -2: "Khối lượng không hợp lệ",
    -3: "Khối lượng phải lớn hơn 0",
    -4: "Khối lượng phải là số nguyên",
    -5: "Khối lượng phải là bội của 100",
  };

  static String mapError(String rc) {
    if (errMsg.containsKey(rc.toString())) {
      return errMsg[rc]!;
    }
    return "Lỗi không xác định! Mã lỗi $rc";
  }

  static String getStatusOrder(IndayOrder idata) {
    var pStatus = idata.status;
    var pMatchVolume = idata.matchVolume;
    var pVolume = idata.volume;
    var pQuote = idata.quote;
    // print(pStatus);
    // print(pMatchVolume);
    // print(pVolume);
    // print(pQuote);

    if ((pStatus == "PMC" || pStatus == "PCM") &&
        int.parse(pMatchVolume!) < int.parse(pVolume!)) {
      return "Khớp 1 phần"; // "MATCH_PARTIAL";
    }
    if ((pStatus == "PMC" || pStatus == "PCM") &&
        int.parse(pMatchVolume!) == int.parse(pVolume!)) {
      return "Đã khớp"; // "MATCH_FULL";
    }

    if ((pStatus == "PMX" || pStatus == "PMWX") &&
        int.parse(pMatchVolume!) > 0) {
      return "Khớp 1 phần đã hủy"; // "MATCH_PARTIAL_CANCELED";
    }
    if (pStatus == "PM" && int.parse(pMatchVolume!) < int.parse(pVolume!)) {
      return "Khớp 1 phần"; // "MATCH_PARTIAL";
    }
    if (pStatus!.substring(pStatus.length - 1, pStatus.length) == "M") {
      //return "MATCH_FULL"
      return "Đã khớp"; // "MATCH_FULL";
    }
    if (pStatus == "PM") {
      // return "MATCH_FULL"
      return "Đã khớp"; // "MATCH_FULL";
    }
    if (pStatus == "PW" || pStatus == "PMW") {
      // return  "MATCH_PENDING"
      return "Chờ hủy"; // "MATCH_PENDING";
    }
    if (pStatus == "PC") {
      if (pQuote == "Y") {
        return "Chờ khớp"; // "MATCH_PENDING";
      } else {
        return "Chờ sửa"; // "EDIT_PENDING"
      }
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "X") {
      return "Đã hủy"; // "CANCELED";
    }
    if (pStatus == "P") {
      return "Chờ khớp"; // "MATCH_PENDING";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "C") {
      return "Chờ khớp"; // "MATCH_PENDING";
    }
    return pStatus;
  }

  static String statusHuySua(IndayOrder idata) {
    var pStatus = idata.status!;
    var pMatchVolume = idata.matchVolume!;
    var pVolume = idata.volume!;
    var pQuote = idata.quote!;

    if ((pStatus == "PMC" || pStatus == "PCM") &&
        int.parse(pMatchVolume) < int.parse(pVolume)) {
      return "MATCH_PARTIAL";
    }
    if ((pStatus == "PMC" || pStatus == "PCM") &&
        int.parse(pMatchVolume) == int.parse(pVolume)) {
      return "MATCH_FULL";
    }

    if ((pStatus == "PMX" || pStatus == "PMWX") &&
        int.parse(pMatchVolume) > 0) {
      return "MATCH_PARTIAL_CANCELED";
    }
    if (pStatus == "PM" && int.parse(pMatchVolume) < int.parse(pVolume)) {
      return "MATCH_PARTIAL";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "M") {
      return "MATCH_FULL";
    }
    if (pStatus == "PM") {
      return "MATCH_FULL";
    }
    if (pStatus == "PW" || pStatus == "PMW") {
      return "MATCH_PENDING";
    }
    if (pStatus == "PC") {
      if (pQuote == "Y") {
        return "MATCH_PENDING";
      } else {
        return "EDIT_PENDING";
      }
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "X") {
      return "CANCELED";
    }
    if (pStatus == "P") {
      return "MATCH_PENDING";
    }
    if (pStatus.substring(pStatus.length - 1, pStatus.length) == "C") {
      return "MATCH_PENDING";
    }
    return pStatus;
  }

  static bool canEdit(IndayOrder data) {
    var ordrStatTp = data.status!;
    var ordrQty = data.volume!;
    var matchedQty = data.matchVolume!;
    if (ordrStatTp == 'P') return true;
    if (ordrStatTp.endsWith('M') &&
        double.parse(matchedQty) < double.parse(ordrQty)) return true;
    if (ordrStatTp == 'PC' && data.quote == "C") return false;
    if ((ordrStatTp == 'P' || ordrStatTp.endsWith('C'))) return true;
    return false;
  }

  static Color getColorStatus(String status) {
    if (status == "MATCH_FULL" ||
        status == "MATCH_PARTIAL" ||
        status == "MATCH_PARTIAL_CANCELED") {
      return AppColors.active;
    }

    if (status == "MATCH_PENDING" || status == "EDIT_PENDING") {
      return const Color.fromRGBO(251, 122, 4, 1);
    }
    if (status == "CANCELED") {
      return AppColors.grey_cancel_order;
    }

    if (status == "EXPIRED") {
      return AppColors.grey_cancel_order;
    }

    if (status == "REJECTED") {
      return AppColors.deActive;
    }
    return AppColors.active;
  }
}
