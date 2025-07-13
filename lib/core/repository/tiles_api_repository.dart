import 'package:saleassist_video_tiles/core/repository/base_api_repository.dart';
import 'package:saleassist_video_tiles/core/services/networking/api/api_response.dart';
import 'package:saleassist_video_tiles/core/services/networking/endpoints.dart';
import 'package:saleassist_video_tiles/core/services/networking/networking.dart';

class TilesApiRepository extends BaseApiRepo {
  Future<APIResponse> getVideoTiles({
    required String playlistId,
  }) async {
    return await NetworkingService()
        .getAPICall(endpoint: Endpoints.getShorts, pathParameters: {
      "playListId": playlistId,
    });
  }
}
