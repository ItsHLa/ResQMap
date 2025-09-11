// ignore_for_file: constant_identifier_names

// const baseUrlHttps = "https://resq-zqbn.onrender.com";
// const baseUrlWss = 'wss://resq-zqbn.onrender.com';

const baseUrlHttps = "https://resqserver.up.railway.app";
const baseUrlWss = 'wss://resqserver.up.railway.app';

abstract class Urls {
  // News
  static const QUACK_NEWS_URL = "$baseUrlHttps/api/aware/news/";
  // Alerts
  static const GET_ALERT_URL = '$baseUrlWss/ws/alerts/emergency/';
  static const POST_ASSIST_URL = "$baseUrlHttps/api/alerts/assist/";
  static const INFO_ALERT_URL = "$baseUrlHttps/api/alerts/get/info/";
  static const TRAK_LOCATION_URL = "$baseUrlHttps/api/maps/location/track/";
  static const MARK_SAFE_URL = "$baseUrlHttps/api/profiles/mark/status/";
  static const GET_DAMAGED_USERS_URL =
      "$baseUrlHttps/api/alerts/users/damaged/get/?q=";
  static const POST_DAMAGED_USER_RESQUED_URL =
      "$baseUrlHttps/api/alerts/users/damaged/mark/";

  // Auth
  static const SIGN_UP_URL = 'https://resq-zqbn.onrender.com/api/auth/signup/emergency/';
  static const LOGIN_URL = '$baseUrlHttps/api/auth/login/';
  static const LOG_OUT_URL = '$baseUrlHttps/api/auth/logout/';
  static const REQUEST_RESET_URL = "https://resq-zqbn.onrender.com/api/auth/otp/generate/reset/";
  static const RESET_COMPLETE_URL = "https://resq-zqbn.onrender.com/api/auth/password/reset/";
  static const VERIFY_EMAIL_URL = "https://resq-zqbn.onrender.com/api/auth/otp/generate/signup/";
  static const GET_TEAM_SKILLS_URL =
      "$baseUrlHttps/api/profiles/team/skills/get/";
  static const POST_TEAM_SKILLS_URL =
      "$baseUrlHttps/api/profiles/team/skills/post/";

  //Safty
  static const GET_USER_STATUS = "$baseUrlHttps/api/profiles/user/status/";
  static const GET_SAFTY_USERS = "$baseUrlHttps/api/profiles/safty/";
  static const DELETE_FROM_MY_SAFTY =
      "$baseUrlHttps/api/profiles/safty/remove/";
  static const ADD_TO_MY_SAFTY = "$baseUrlHttps/api/profiles/safty/add/";
  static const SEARCH_USERS = "$baseUrlHttps/api/profiles/search/?q=";
}

//Auth Audit
const authAuditUrl = "$baseUrlHttps/api/auth/audit/";

//Profile
const getProfileUrl = "$baseUrlHttps/api/profiles/";
const updatePersonalInfo = "$baseUrlHttps/api/profiles/update/personal/info/";
const updateUserInfo = "$baseUrlHttps/api/profiles/update/user/info/";

const updateProfilePhotoUrl = "$baseUrlHttps/api/profiles/update/photo/";
const deleteProfilePhotoUrl = "$baseUrlHttps/api/profiles/delete/photo/";

const deleteProfileUrl = "$baseUrlHttps/api/profiles/delete/";
const deactiveProfileUrl = "$baseUrlHttps/api/profiles/deactivate/";

const changePasswordUrl = '$baseUrlHttps/api/auth/password/change/';

//Map
const routeUrl = "$baseUrlHttps/api/maps/path/route/";
