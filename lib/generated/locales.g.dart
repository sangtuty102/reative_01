/// Cung cấp dữ liệu đa ngôn ngữ cho toàn bộ ứng dụng.
/// File này được sinh tự động bởi scripts/gen_lang.dart
/// Vui lòng KHÔNG sửa trực tiếp file này.

import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': Locales.en_US,
        'vi_VN': Locales.vi_VN,
      };
}

class Locales {
  static const en_US = {
    'common_hello': 'Hello',
    'common_error_occurred': 'An error occurred. Please try again!',
    'common_loading': 'Loading...',
    'common_error': 'Error',
    'common_success': 'Success',
    'common_cancel': 'Cancel',
    'common_continue': 'Continue',
    'common_verify': 'Verify',
    'common_skip': 'Skip',
    'common_update': 'Update',
    'common_notification': 'Notification',
    'home_current_version': 'Current version: ',
    'home_stats': 'Stats',
    'home_settings': 'Settings',
    'home_home': 'Home',
    'home_check_update': 'Check for update',
    'home_push_button_msg': 'You have pushed the button this many times:',
    'home_system_stats': 'System Statistics',
    'home_system_stats_desc': 'Overview of app performance and activities',
    'home_click_count': 'Click count',
    'home_version': 'Version',
    'home_environment': 'Environment',
    'home_security': 'Security',
    'home_security_standard_met': 'Standard met',
    'home_server_status': 'Server Status',
    'home_gateway_api': 'Gateway API',
    'home_active': 'Active',
    'home_update_service': 'Update Service',
    'home_ready': 'Ready',
    'home_database': 'Database',
    'home_online': 'Online',
    'home_app_config': 'App Configuration',
    'home_primary_color': 'Primary Color',
    'home_logout': 'Logout',
    'home_app_up_to_date': 'App is up to date!',
    'home_update_check_error': 'Update check error: ',
    'home_new_version_available': 'New Version Available! (v',
    'home_new_features': 'New features:',
    'home_downloading_update': 'Downloading update...',
    'home_prompt_download_update':
        'Do you want to download and install the update now?',
    'home_preferences': 'Preferences',
    'home_dark_mode': 'Dark Mode',
    'home_english_language': 'English Language',
    'login_login': 'Login',
    'login_please_enter_phone': 'Please enter phone number',
    'login_invalid_phone': 'Invalid phone number (9 to 11 digits required)',
    'login_please_enter_password': 'Please enter password',
    'login_password_too_short': 'Password must be at least 6 characters',
    'login_login_failed': 'Login failed: ',
    'login_forgot_password': 'Forgot password?',
    'login_login_subtitle': 'Please login to continue',
    'login_phone_number': 'Phone number',
    'login_password': 'Password',
    'login_recover_password': 'Recover Password',
    'login_verify_otp': 'Verify OTP',
    'login_enter_account_or_phone_prompt':
        'Enter your registered account or phone number:',
    'login_account_or_phone': 'Account / Phone number',
    'login_enter_otp_prompt':
        'Please enter the 6-digit OTP sent to your phone number:',
    'login_otp_code': 'OTP Code',
    'login_please_enter_account_or_phone':
        'Please enter account or phone number',
    'login_invalid_account_or_phone':
        'Invalid account or phone (9-11 digits required)',
    'login_otp_sent_to_account':
        'OTP has been sent to the registered number for account ',
    'login_system_error_sending_otp': 'System error sending OTP: ',
    'login_please_enter_otp': 'Please enter OTP',
    'login_otp_must_be_6_digits': 'OTP must be exactly 6 digits',
    'login_otp_verified_new_password_sent':
        'OTP verified successfully. A new password has been sent via SMS!',
    'login_invalid_or_expired_otp': 'Invalid or expired OTP: ',
  };
  static const vi_VN = {
    'common_hello': 'Xin chào',
    'common_error_occurred': 'Đã xảy ra lỗi. Vui lòng thử lại!',
    'common_loading': 'Đang tải...',
    'common_error': 'Lỗi',
    'common_success': 'Thành công',
    'common_cancel': 'Hủy',
    'common_continue': 'Tiếp tục',
    'common_verify': 'Xác thực',
    'common_skip': 'Bỏ qua',
    'common_update': 'Cập nhật',
    'common_notification': 'Thông báo',
    'home_current_version': 'Phiên bản hiện tại: ',
    'home_stats': 'Thống Kê',
    'home_settings': 'Cài Đặt',
    'home_home': 'Trang chủ',
    'home_check_update': 'Kiểm tra cập nhật',
    'home_push_button_msg': 'Bạn đã bấm nút này số lần:',
    'home_system_stats': 'Thống kê hệ thống',
    'home_system_stats_desc': 'Tổng quan hoạt động và hiệu năng ứng dụng',
    'home_click_count': 'Số lần Click',
    'home_version': 'Phiên bản',
    'home_environment': 'Môi trường',
    'home_security': 'Bảo mật',
    'home_security_standard_met': 'Đạt chuẩn',
    'home_server_status': 'Trạng thái máy chủ',
    'home_gateway_api': 'Gateway API',
    'home_active': 'Đang hoạt động',
    'home_update_service': 'Dịch vụ Cập nhật',
    'home_ready': 'Sẵn sàng',
    'home_database': 'Cơ sở dữ liệu',
    'home_online': 'Trực tuyến',
    'home_app_config': 'Cấu hình ứng dụng',
    'home_primary_color': 'Màu chủ đạo',
    'home_logout': 'Đăng xuất',
    'home_app_up_to_date': 'Ứng dụng đã ở phiên bản mới nhất!',
    'home_update_check_error': 'Lỗi kiểm tra cập nhật: ',
    'home_new_version_available': 'Có Phiên Bản Mới! (v',
    'home_new_features': 'Tính năng mới:',
    'home_downloading_update': 'Đang tải bản cập nhật...',
    'home_prompt_download_update':
        'Bạn có muốn tải xuống và cài đặt bản cập nhật ngay bây giờ?',
    'home_preferences': 'Tùy chỉnh cá nhân',
    'home_dark_mode': 'Giao diện tối',
    'home_english_language': 'Ngôn ngữ Tiếng Anh',
    'login_login': 'Đăng nhập',
    'login_please_enter_phone': 'Vui lòng nhập số điện thoại',
    'login_invalid_phone':
        'Số điện thoại không hợp lệ (yêu cầu từ 9 đến 11 chữ số)',
    'login_please_enter_password': 'Vui lòng nhập mật khẩu',
    'login_password_too_short': 'Mật khẩu phải chứa ít nhất 6 ký tự',
    'login_login_failed': 'Đăng nhập không thành công: ',
    'login_forgot_password': 'Quên mật khẩu?',
    'login_login_subtitle': 'Vui lòng đăng nhập để tiếp tục',
    'login_phone_number': 'Số điện thoại',
    'login_password': 'Mật khẩu',
    'login_recover_password': 'Khôi phục mật khẩu',
    'login_verify_otp': 'Xác thực OTP',
    'login_enter_account_or_phone_prompt':
        'Nhập số tài khoản hoặc số điện thoại đăng ký tài khoản của bạn:',
    'login_account_or_phone': 'Số tài khoản / Số điện thoại',
    'login_enter_otp_prompt':
        'Vui lòng nhập mã xác thực OTP (6 chữ số) vừa được gửi đến số điện thoại của bạn:',
    'login_otp_code': 'Mã OTP',
    'login_please_enter_account_or_phone':
        'Vui lòng nhập số tài khoản hoặc số điện thoại',
    'login_invalid_account_or_phone':
        'Số tài khoản hoặc số điện thoại không hợp lệ (yêu cầu từ 9 đến 11 chữ số)',
    'login_otp_sent_to_account':
        'Mã OTP đã được gửi đến số đăng ký của tài khoản ',
    'login_system_error_sending_otp': 'Lỗi hệ thống khi gửi mã: ',
    'login_please_enter_otp': 'Vui lòng nhập mã OTP',
    'login_otp_must_be_6_digits': 'Mã OTP phải gồm 6 chữ số',
    'login_otp_verified_new_password_sent':
        'Xác thực OTP thành công. Mật khẩu mới đã được gửi qua tin nhắn SMS!',
    'login_invalid_or_expired_otp': 'Mã OTP không chính xác hoặc đã hết hạn: ',
  };
}

abstract class LocaleKeys {
  static const commonCancel = 'common_cancel';
  static const commonContinue = 'common_continue';
  static const commonError = 'common_error';
  static const commonErrorOccurred = 'common_error_occurred';
  static const commonHello = 'common_hello';
  static const commonLoading = 'common_loading';
  static const commonNotification = 'common_notification';
  static const commonSkip = 'common_skip';
  static const commonSuccess = 'common_success';
  static const commonUpdate = 'common_update';
  static const commonVerify = 'common_verify';
  static const homeActive = 'home_active';
  static const homeAppConfig = 'home_app_config';
  static const homeAppUpToDate = 'home_app_up_to_date';
  static const homeCheckUpdate = 'home_check_update';
  static const homeClickCount = 'home_click_count';
  static const homeCurrentVersion = 'home_current_version';
  static const homeDatabase = 'home_database';
  static const homeDownloadingUpdate = 'home_downloading_update';
  static const homeEnvironment = 'home_environment';
  static const homeGatewayApi = 'home_gateway_api';
  static const homeHome = 'home_home';
  static const homeLogout = 'home_logout';
  static const homeNewFeatures = 'home_new_features';
  static const homeNewVersionAvailable = 'home_new_version_available';
  static const homeOnline = 'home_online';
  static const homePrimaryColor = 'home_primary_color';
  static const homePromptDownloadUpdate = 'home_prompt_download_update';
  static const homePreferences = 'home_preferences';
  static const homeDarkMode = 'home_dark_mode';
  static const homeEnglishLanguage = 'home_english_language';
  static const homePushButtonMsg = 'home_push_button_msg';
  static const homeReady = 'home_ready';
  static const homeSecurity = 'home_security';
  static const homeSecurityStandardMet = 'home_security_standard_met';
  static const homeServerStatus = 'home_server_status';
  static const homeSettings = 'home_settings';
  static const homeStats = 'home_stats';
  static const homeSystemStats = 'home_system_stats';
  static const homeSystemStatsDesc = 'home_system_stats_desc';
  static const homeUpdateCheckError = 'home_update_check_error';
  static const homeUpdateService = 'home_update_service';
  static const homeVersion = 'home_version';
  static const loginAccountOrPhone = 'login_account_or_phone';
  static const loginEnterAccountOrPhonePrompt =
      'login_enter_account_or_phone_prompt';
  static const loginEnterOtpPrompt = 'login_enter_otp_prompt';
  static const loginForgotPassword = 'login_forgot_password';
  static const loginInvalidAccountOrPhone = 'login_invalid_account_or_phone';
  static const loginInvalidOrExpiredOtp = 'login_invalid_or_expired_otp';
  static const loginInvalidPhone = 'login_invalid_phone';
  static const loginLogin = 'login_login';
  static const loginLoginFailed = 'login_login_failed';
  static const loginLoginSubtitle = 'login_login_subtitle';
  static const loginOtpCode = 'login_otp_code';
  static const loginOtpMustBe6Digits = 'login_otp_must_be_6_digits';
  static const loginOtpSentToAccount = 'login_otp_sent_to_account';
  static const loginOtpVerifiedNewPasswordSent =
      'login_otp_verified_new_password_sent';
  static const loginPassword = 'login_password';
  static const loginPasswordTooShort = 'login_password_too_short';
  static const loginPhoneNumber = 'login_phone_number';
  static const loginPleaseEnterAccountOrPhone =
      'login_please_enter_account_or_phone';
  static const loginPleaseEnterOtp = 'login_please_enter_otp';
  static const loginPleaseEnterPassword = 'login_please_enter_password';
  static const loginPleaseEnterPhone = 'login_please_enter_phone';
  static const loginRecoverPassword = 'login_recover_password';
  static const loginSystemErrorSendingOtp = 'login_system_error_sending_otp';
  static const loginVerifyOtp = 'login_verify_otp';
}
