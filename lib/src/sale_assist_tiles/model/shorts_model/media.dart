import 'package:equatable/equatable.dart';

import 'style.dart';

class Media extends Equatable {
  final String? id;
  final String? caption;
  final String? media;
  final String? processedMedia;
  final String? ctaClickFunction;
  final String? pinnedMessage;
  final String? whatsappMessage;
  final String? ctaLink;
  final String? ctaText;
  final List<dynamic>? products;
  final List<dynamic>? productOffers;
  final List<dynamic>? aiContextJson;
  final List<dynamic>? aiFaqContextJson;
  final Style? style;
  final String? thumbnailUrl;
  final String? tagView;
  final List<dynamic>? ctaConfig;
  final int? views;
  final int? likes;
  final String? shortVideoUrl;
  final bool? deleted;

  const Media({
    this.id,
    this.caption,
    this.media,
    this.processedMedia,
    this.ctaClickFunction,
    this.pinnedMessage,
    this.whatsappMessage,
    this.ctaLink,
    this.ctaText,
    this.products,
    this.productOffers,
    this.aiContextJson,
    this.aiFaqContextJson,
    this.style,
    this.thumbnailUrl,
    this.tagView,
    this.ctaConfig,
    this.views,
    this.likes,
    this.shortVideoUrl,
    this.deleted,
  });

  factory Media.fromMap(Map<String, dynamic> json) => Media(
        id: json['id'] as String?,
        caption: json['caption'] as String?,
        media: json['media'] as String?,
        processedMedia: json['processed_media'] as String?,
        ctaClickFunction: json['cta_click_function'] as String?,
        pinnedMessage: json['pinned_message'] as String?,
        whatsappMessage: json['whatsapp_message'] as String?,
        ctaLink: json['cta_link'] as String?,
        ctaText: json['cta_text'] as String?,
        products: json['products'] as List<dynamic>?,
        productOffers: json['product_offers'] as List<dynamic>?,
        aiContextJson: json['ai_context_json'] as List<dynamic>?,
        aiFaqContextJson: json['ai_faq_context_json'] as List<dynamic>?,
        style: json['style'] == null
            ? null
            : Style.fromMap(json['style'] as Map<String, dynamic>),
        thumbnailUrl: json['thumbnail_url'] as String?,
        tagView: json['tag_view'] as String?,
        ctaConfig: json['cta_config'] as List<dynamic>?,
        views: json['views'] as int?,
        likes: json['likes'] as int?,
        shortVideoUrl: json['short_video_url'] as String?,
        deleted: json['deleted'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'caption': caption,
        'media': media,
        'processed_media': processedMedia,
        'cta_click_function': ctaClickFunction,
        'pinned_message': pinnedMessage,
        'whatsapp_message': whatsappMessage,
        'cta_link': ctaLink,
        'cta_text': ctaText,
        'products': products,
        'product_offers': productOffers,
        'ai_context_json': aiContextJson,
        'ai_faq_context_json': aiFaqContextJson,
        'style': style?.toMap(),
        'thumbnail_url': thumbnailUrl,
        'tag_view': tagView,
        'cta_config': ctaConfig,
        'views': views,
        'likes': likes,
        'short_video_url': shortVideoUrl,
        'deleted': deleted,
      };

  Media copyWith({
    String? id,
    String? caption,
    String? media,
    String? processedMedia,
    String? ctaClickFunction,
    String? pinnedMessage,
    String? whatsappMessage,
    String? ctaLink,
    String? ctaText,
    List<dynamic>? products,
    List<dynamic>? productOffers,
    List<dynamic>? aiContextJson,
    List<dynamic>? aiFaqContextJson,
    Style? style,
    String? thumbnailUrl,
    String? tagView,
    List<dynamic>? ctaConfig,
    int? views,
    int? likes,
    String? shortVideoUrl,
    bool? deleted,
  }) {
    return Media(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      media: media ?? this.media,
      processedMedia: processedMedia ?? this.processedMedia,
      ctaClickFunction: ctaClickFunction ?? this.ctaClickFunction,
      pinnedMessage: pinnedMessage ?? this.pinnedMessage,
      whatsappMessage: whatsappMessage ?? this.whatsappMessage,
      ctaLink: ctaLink ?? this.ctaLink,
      ctaText: ctaText ?? this.ctaText,
      products: products ?? this.products,
      productOffers: productOffers ?? this.productOffers,
      aiContextJson: aiContextJson ?? this.aiContextJson,
      aiFaqContextJson: aiFaqContextJson ?? this.aiFaqContextJson,
      style: style ?? this.style,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      tagView: tagView ?? this.tagView,
      ctaConfig: ctaConfig ?? this.ctaConfig,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      shortVideoUrl: shortVideoUrl ?? this.shortVideoUrl,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      caption,
      media,
      processedMedia,
      ctaClickFunction,
      pinnedMessage,
      whatsappMessage,
      ctaLink,
      ctaText,
      products,
      productOffers,
      aiContextJson,
      aiFaqContextJson,
      style,
      thumbnailUrl,
      tagView,
      ctaConfig,
      views,
      likes,
      shortVideoUrl,
      deleted,
    ];
  }
}
