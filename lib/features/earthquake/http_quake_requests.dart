import 'package:resq_map/core/services/http.dart';
import 'package:resq_map/core/services/urls.dart';
import 'package:resq_map/features/authentication/utils/auth_service.dart';

abstract class HttpQuakeRequests {
  @pragma('vm:entry-point')
  static markSafe(bool status) async {
    String? token = await AuthService.getAuthToken();
    var response = await HttpService.put(
      token: token,
      uri: Urls.MARK_SAFE_URL,
      body: {"is_marked_safe": status},
    );
    print(response);
    return response;
  }
}
