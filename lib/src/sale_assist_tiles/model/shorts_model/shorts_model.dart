import 'package:equatable/equatable.dart';
import 'package:saleassist_video_tiles/src/sale_assist_tiles/model/shorts_model/media/media.dart';


class ShortsModel extends Equatable {
  final String? name;
  final bool? highlight;
  final String? themeColor;
  final String? highlightedVideoId;
  final bool? autoPlay;
  final bool? isCaptureForm;
  final String? leadForm;
  final String? uniqueFieldName;
  final String? layoutView;
  final bool? animatedThumbnail;
  final bool? isLiveStreaming;
  final String? agentAvatar;
  final bool? isWhatsappMe;
  final String? whatsappNumber;
  final String? themeMode;
  final String? liveStreamingType;
  final bool? disableVideoControls;
  final String? id;
  final String? clientId;
  final bool? isShopifyConnected;
  final List<Media>? media;

  const ShortsModel({
    this.name,
    this.highlight,
    this.themeColor,
    this.highlightedVideoId,
    this.autoPlay,
    this.isCaptureForm,
    this.leadForm,
    this.uniqueFieldName,
    this.layoutView,
    this.animatedThumbnail,
    this.isLiveStreaming,
    this.agentAvatar,
    this.isWhatsappMe,
    this.whatsappNumber,
    this.themeMode,
    this.liveStreamingType,
    this.disableVideoControls,
    this.id,
    this.clientId,
    this.isShopifyConnected,
    this.media,
  });

  factory ShortsModel.fromMap(Map<String, dynamic> json) => ShortsModel(
        name: json['name'] as String?,
        highlight: json['highlight'] as bool?,
        themeColor: json['theme_color'] as String?,
        highlightedVideoId: json['highlighted_video_id'] as String?,
        autoPlay: json['auto_play'] as bool?,
        isCaptureForm: json['is_capture_form'] as bool?,
        leadForm: json['lead_form'] as String?,
        uniqueFieldName: json['unique_field_name'] as String?,
        layoutView: json['layout_view'] as String?,
        animatedThumbnail: json['animated_thumbnail'] as bool?,
        isLiveStreaming: json['is_live_streaming'] as bool?,
        agentAvatar: json['agent_avatar'] as String?,
        isWhatsappMe: json['is_whatsapp_me'] as bool?,
        whatsappNumber: json['whatsapp_number'] as String?,
        themeMode: json['theme_mode'] as String?,
        liveStreamingType: json['live_streaming_type'] as String?,
        disableVideoControls: json['disable_video_controls'] as bool?,
        id: json['id'] as String?,
        clientId: json['client_id'] as String?,
        isShopifyConnected: json['is_shopify_connected'] as bool?,
        media: (json['media'] as List<dynamic>?)
            ?.map((e) => Media.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'highlight': highlight,
        'theme_color': themeColor,
        'highlighted_video_id': highlightedVideoId,
        'auto_play': autoPlay,
        'is_capture_form': isCaptureForm,
        'lead_form': leadForm,
        'unique_field_name': uniqueFieldName,
        'layout_view': layoutView,
        'animated_thumbnail': animatedThumbnail,
        'is_live_streaming': isLiveStreaming,
        'agent_avatar': agentAvatar,
        'is_whatsapp_me': isWhatsappMe,
        'whatsapp_number': whatsappNumber,
        'theme_mode': themeMode,
        'live_streaming_type': liveStreamingType,
        'disable_video_controls': disableVideoControls,
        'id': id,
        'client_id': clientId,
        'is_shopify_connected': isShopifyConnected,
        'media': media?.map((e) => e.toMap()).toList(),
      };

  ShortsModel copyWith({
    String? name,
    bool? highlight,
    String? themeColor,
    String? highlightedVideoId,
    bool? autoPlay,
    bool? isCaptureForm,
    String? leadForm,
    String? uniqueFieldName,
    String? layoutView,
    bool? animatedThumbnail,
    bool? isLiveStreaming,
    String? agentAvatar,
    bool? isWhatsappMe,
    String? whatsappNumber,
    String? themeMode,
    String? liveStreamingType,
    bool? disableVideoControls,
    String? id,
    String? clientId,
    bool? isShopifyConnected,
    List<Media>? media,
  }) {
    return ShortsModel(
      name: name ?? this.name,
      highlight: highlight ?? this.highlight,
      themeColor: themeColor ?? this.themeColor,
      highlightedVideoId: highlightedVideoId ?? this.highlightedVideoId,
      autoPlay: autoPlay ?? this.autoPlay,
      isCaptureForm: isCaptureForm ?? this.isCaptureForm,
      leadForm: leadForm ?? this.leadForm,
      uniqueFieldName: uniqueFieldName ?? this.uniqueFieldName,
      layoutView: layoutView ?? this.layoutView,
      animatedThumbnail: animatedThumbnail ?? this.animatedThumbnail,
      isLiveStreaming: isLiveStreaming ?? this.isLiveStreaming,
      agentAvatar: agentAvatar ?? this.agentAvatar,
      isWhatsappMe: isWhatsappMe ?? this.isWhatsappMe,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      themeMode: themeMode ?? this.themeMode,
      liveStreamingType: liveStreamingType ?? this.liveStreamingType,
      disableVideoControls: disableVideoControls ?? this.disableVideoControls,
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      isShopifyConnected: isShopifyConnected ?? this.isShopifyConnected,
      media: media ?? this.media,
    );
  }

  @override
  List<Object?> get props {
    return [
      name,
      highlight,
      themeColor,
      highlightedVideoId,
      autoPlay,
      isCaptureForm,
      leadForm,
      uniqueFieldName,
      layoutView,
      animatedThumbnail,
      isLiveStreaming,
      agentAvatar,
      isWhatsappMe,
      whatsappNumber,
      themeMode,
      liveStreamingType,
      disableVideoControls,
      id,
      clientId,
      isShopifyConnected,
      media,
    ];
  }
}
