import 'dart:convert';

ProductSectionEntity productSectionEntityFromJson(String str) =>
    ProductSectionEntity.fromJson(json.decode(str));

String productSectionEntityToJson(ProductSectionEntity data) =>
    json.encode(data.toJson());

class ProductSectionEntity {
  List<Result> results;

  ProductSectionEntity({
    required this.results,
  });

  factory ProductSectionEntity.fromJson(Map<String, dynamic> json) =>
      ProductSectionEntity(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String code;
  String name;

  Price price;
  List<GalleryImage> images;

  List<Article> articles;

  Article defaultArticle;

  String brandName;

  Result({
    required this.code,
    required this.name,
    required this.price,
    required this.images,
    required this.articles,
    required this.defaultArticle,
    required this.brandName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        code: json["code"],
        name: json["name"],
        price: Price.fromJson(json["price"]),
        images: List<GalleryImage>.from(
            json["images"].map((x) => GalleryImage.fromJson(x))),
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
        defaultArticle: Article.fromJson(json["defaultArticle"]),
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "price": price.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
        "defaultArticle": defaultArticle.toJson(),
        "brandName": brandName,
      };
}

class Article {
  String code;
  String name;
  Price whitePrice;
  List<GalleryImage> images;
  List<GalleryImage> logoPicture;
  List<GalleryImage> normalPicture;

  String rgbColor;

  Article({
    required this.code,
    required this.name,
    required this.whitePrice,
    required this.images,
    required this.logoPicture,
    required this.normalPicture,
    required this.rgbColor,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        code: json["code"],
        name: json["name"],
        images: List<GalleryImage>.from(
            json["images"].map((x) => GalleryImage.fromJson(x))),
        whitePrice: Price.fromJson(json["whitePrice"]),
        logoPicture: List<GalleryImage>.from(
            json["logoPicture"].map((x) => GalleryImage.fromJson(x))),
        normalPicture: List<GalleryImage>.from(
            json["normalPicture"].map((x) => GalleryImage.fromJson(x))),
        rgbColor: json["rgbColor"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "whitePrice": whitePrice.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "logoPicture": List<dynamic>.from(logoPicture.map((x) => x.toJson())),
        "normalPicture":
            List<dynamic>.from(normalPicture.map((x) => x.toJson())),
        "rgbColor": rgbColor,
      };
}

class GalleryImage {
  String url;
  String baseUrl;

  GalleryImage({
    required this.url,
    required this.baseUrl,
  });

  factory GalleryImage.fromJson(Map<String, dynamic> json) => GalleryImage(
        url: json["url"],
        baseUrl: json["baseUrl"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "baseUrl": baseUrl,
      };
}

class Price {
  String currencyIso;
  double value;
  String priceType;
  String formattedValue;
  String type;

  Price({
    required this.currencyIso,
    required this.value,
    required this.priceType,
    required this.formattedValue,
    required this.type,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        currencyIso: json["currencyIso"],
        value: json["value"]?.toDouble(),
        priceType: json["priceType"],
        formattedValue: json["formattedValue"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "currencyIso": currencyIso,
        "value": value,
        "priceType": priceType,
        "formattedValue": formattedValue,
        "type": type,
      };
}
