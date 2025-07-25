const baseUrlHttps = "https://resq-zqbn.onrender.com";
const baseUrlWss = 'wss://resq-zqbn.onrender.com';

// Auth
const signUpUrl = '$baseUrlHttps/api/auth/signup/emergency/';
const logInUrl = '$baseUrlHttps/api/auth/login/';
const logOutUrl = '$baseUrlHttps/api/auth/logout/';
const requestResetUrl = "$baseUrlHttps/api/auth/otp/generate/reset/";
const resetCompleteUrl = "$baseUrlHttps/api/auth/password/reset/";
const verifyEmailUrl = "$baseUrlHttps/api/auth/otp/generate/signup/";
const getTeamSkillsUrl = "$baseUrlHttps/api/profiles/team/skills/get/";
const postTeamSkillsUrl = "$baseUrlHttps/api/profiles/team/skills/post/";

//Auth Audit
const authAuditUrl = "$baseUrlHttps/api/auth/audit/";

// News
const newsUrl = "$baseUrlHttps/api/aware/news/";

// Alerts
const alertsUrl = '$baseUrlWss/ws/alerts/emergency/';
const postAssist = "$baseUrlHttps/api/alerts/assist/";
const infoAlertUrl = "$baseUrlHttps/api/alerts/get/info/";

//Profile
const getProfileUrl = "$baseUrlHttps/api/profiles/";
const updatePersonalInfo = "$baseUrlHttps/api/profiles/update/personal/info/";
const updateUserInfo = "$baseUrlHttps/api/profiles/update/user/info/";
const updateProfilePhotoUrl = "$baseUrlHttps/api/profiles/update/photo/";
const deleteProfileUrl = "$baseUrlHttps/api/profiles/delete/";
const deactiveProfileUrl = "$baseUrlHttps/api/profiles/deactivate/";
const changePasswordUrl = '$baseUrlHttps/api/auth/password/change/';

//Map
const routeUrl = "$baseUrlHttps/api/maps/path/route/";
