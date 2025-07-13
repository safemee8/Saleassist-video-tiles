class SaleassistTileEvent {}

class SaleassistTileLoadEvent extends SaleassistTileEvent {
  final List<String> videos;
  final String playlistId;

  SaleassistTileLoadEvent({required this.videos, required this.playlistId});
}
