import 'package:equatable/equatable.dart';

import 'product_media.dart';

class Product extends Equatable {
  final String? productName;
  final String? productDisplayImage;
  final String? productCtaText;
  final List<String>? productImages;
  final String? productUrl;
  final String? productSku;
  final double? productPrice;
  final double? offerPrice;
  final String? productCurrency;
  final String? productDescription;
  final int? inventoryCount;
  final int? biddingFloorAmount;
  final int? biddingCapAmount;
  final int? bookingAmount;
  final int? allowedQuantity;
  final String? variantId;
  final ProductMedia? productMedia;
  final String? id;
  final String? shopifyDomain;

  const Product({
    this.productName,
    this.productDisplayImage,
    this.productCtaText,
    this.productImages,
    this.productUrl,
    this.productSku,
    this.productPrice,
    this.offerPrice,
    this.productCurrency,
    this.productDescription,
    this.inventoryCount,
    this.biddingFloorAmount,
    this.biddingCapAmount,
    this.bookingAmount,
    this.allowedQuantity,
    this.variantId,
    this.productMedia,
    this.id,
    this.shopifyDomain,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        productName: json['product_name'] as String?,
        productDisplayImage: json['product_display_image'] as String?,
        productCtaText: json['product_cta_text'] as String?,
        productImages: (json['product_images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        productUrl: json['product_url'] as String?,
        productSku: json['product_sku'] as String?,
        productPrice: double.parse(json['product_price'].toString()),
        offerPrice: double.parse(json['offer_price'].toString()),
        productCurrency: json['product_currency'] as String?,
        productDescription: json['product_description'] as String?,
        // inventoryCount: json['inventory_count'] as int?,
        // biddingFloorAmount: json['bidding_floor_amount'] as int?,
        // biddingCapAmount: json['bidding_cap_amount'] as int?,
        // bookingAmount: json['booking_amount'] as int?,
        // allowedQuantity: json['allowed_quantity'] as int?,
        variantId: json['variant_id'] as String?,
        // productMedia: json['product_media'] == null
        //     ? null
        //     : ProductMedia.fromMap(
        //         json['product_media'] as Map<String, dynamic>),
        id: json['id'] as String?,
        shopifyDomain: json['shopify_domain'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'product_name': productName,
        'product_display_image': productDisplayImage,
        'product_cta_text': productCtaText,
        'product_images': productImages,
        'product_url': productUrl,
        'product_sku': productSku,
        'product_price': productPrice,
        'offer_price': offerPrice,
        'product_currency': productCurrency,
        'product_description': productDescription,
        'inventory_count': inventoryCount,
        'bidding_floor_amount': biddingFloorAmount,
        'bidding_cap_amount': biddingCapAmount,
        'booking_amount': bookingAmount,
        'allowed_quantity': allowedQuantity,
        'variant_id': variantId,
        // 'product_media': productMedia?.toMap(),
        'id': id,
        'shopify_domain': shopifyDomain,
      };

  Product copyWith({
    String? productName,
    String? productDisplayImage,
    String? productCtaText,
    List<String>? productImages,
    String? productUrl,
    String? productSku,
    double? productPrice,
    double? offerPrice,
    String? productCurrency,
    String? productDescription,
    int? inventoryCount,
    int? biddingFloorAmount,
    int? biddingCapAmount,
    int? bookingAmount,
    int? allowedQuantity,
    String? variantId,
    ProductMedia? productMedia,
    String? id,
    String? shopifyDomain,
  }) {
    return Product(
      productName: productName ?? this.productName,
      productDisplayImage: productDisplayImage ?? this.productDisplayImage,
      productCtaText: productCtaText ?? this.productCtaText,
      productImages: productImages ?? this.productImages,
      productUrl: productUrl ?? this.productUrl,
      productSku: productSku ?? this.productSku,
      productPrice: productPrice ?? this.productPrice,
      offerPrice: offerPrice ?? this.offerPrice,
      productCurrency: productCurrency ?? this.productCurrency,
      productDescription: productDescription ?? this.productDescription,
      inventoryCount: inventoryCount ?? this.inventoryCount,
      biddingFloorAmount: biddingFloorAmount ?? this.biddingFloorAmount,
      biddingCapAmount: biddingCapAmount ?? this.biddingCapAmount,
      bookingAmount: bookingAmount ?? this.bookingAmount,
      allowedQuantity: allowedQuantity ?? this.allowedQuantity,
      variantId: variantId ?? this.variantId,
      productMedia: productMedia ?? this.productMedia,
      id: id ?? this.id,
      shopifyDomain: shopifyDomain ?? this.shopifyDomain,
    );
  }

  @override
  List<Object?> get props {
    return [
      productName,
      productDisplayImage,
      productCtaText,
      productImages,
      productUrl,
      productSku,
      productPrice,
      offerPrice,
      productCurrency,
      productDescription,
      inventoryCount,
      biddingFloorAmount,
      biddingCapAmount,
      bookingAmount,
      allowedQuantity,
      variantId,
      productMedia,
      id,
      shopifyDomain,
    ];
  }
}
