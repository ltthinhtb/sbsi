class AppConfigs {
  static const String appName = 'VFtrade';

  ///DEV

  ///STAGING
  static const envName = "Staging";
  static const baseUrl = "http://14.238.11.1:9999/";
  static const URL_DATA_FEED = 'https://sbboard.sbsi.vn/';
  static const INFO_SBSI = 'https://info.sbsi.vn/';
  static const ENDPOINT_CORE = 'TraditionalService';
  static const NOTIFICATION = 'http://14.238.11.1:8998/';
  static const SIGN_UP_URL = 'http://14.238.11.1:8998/'; //Todo: change this
  static const socketUrl = 'https://sbboard.sbsi.vn/ps'; //Todo: change this

  ///PRODUCTION

  ///Paging
  static const pageSize = 20;
  static const pageSizeMax = 1000;

  ///Local
  static const appLocal = 'vi_VN';
  static const appLanguage = 'en';

  ///DateFormat

  static const dateAPIFormat = 'dd/MM/yyyy';
  static const dateDisplayFormat = 'dd/MM/yyyy';

  static const dateTimeAPIFormat =
      "MM/dd/yyyy'T'hh:mm:ss.SSSZ"; //Use DateTime.parse(date) instead of ...
  static const dateTimeDisplayFormat = 'dd/MM/yyyy HH:mm';

  ///Date range
  static final identityMinDate = DateTime(1900, 1, 1);
  static final identityMaxDate = DateTime.now();
  static final birthMinDate = DateTime(1900, 1, 1);
  static final birthMaxDate = DateTime.now();

  ///Font
  static const fontFamily = 'Roboto';

  ///Max file
  static const maxAttachFile = 5;
}

class FirebaseConfig {
  //Todo
}

class DatabaseConfig {
  //Todo
  static const int version = 1;
}
