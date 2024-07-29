class AppConfig {
  static const String baseurl = "http://be.mandgholidays.com/api/app/";
  static const String loginData = 'logInData';
  static const String OTPData = 'OTPData';
  static const String loggedIn = 'loggedIn';
  static const String OTPSent = 'OTPSent';
  static const String token = "token";
  static  int id = "id" as int;
  //key to store username which user entered used in registration page controller, login page controller
  static const String userName = "username";

  //key to check whether the user is already registered  or not and navigate to login page on every other startup since registering.
  static const String status = "status";
}