import 'package:flutter/foundation.dart';

class NewModel {
  final Meta? meta;
  final List<Data>? data;

  NewModel({
    this.meta,
    this.data,
  });

  NewModel.fromJson(Map<String, dynamic> json)
      : meta = (json['meta'] as Map<String, dynamic>?) != null
            ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
            : null,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'meta': meta?.toJson(), 'data': data?.map((e) => e.toJson()).toList()};

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewModel &&
        other.meta == meta &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => meta.hashCode ^ data.hashCode;
}

class Meta {
  final int? found;
  final int? returned;
  final int? limit;
  final int? page;

  Meta({
    this.found,
    this.returned,
    this.limit,
    this.page,
  });

  Meta.fromJson(Map<String, dynamic> json)
      : found = json['found'] as int?,
        returned = json['returned'] as int?,
        limit = json['limit'] as int?,
        page = json['page'] as int?;

  Map<String, dynamic> toJson() =>
      {'found': found, 'returned': returned, 'limit': limit, 'page': page};
}

class Data {
  final String? uuid;
  final String? title;
  final String? description;
  final String? keywords;
  final String? snippet;
  final String? url;
  final String? imageUrl;
  final String? language;
  final String? publishedAt;
  final String? source;
  final dynamic relevanceScore;
  final List<dynamic>? entities;
  final List<Similar>? similar;

  Data({
    this.uuid,
    this.title,
    this.description,
    this.keywords,
    this.snippet,
    this.url,
    this.imageUrl,
    this.language,
    this.publishedAt,
    this.source,
    this.relevanceScore,
    this.entities,
    this.similar,
  });

  Data.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        keywords = json['keywords'] as String?,
        snippet = json['snippet'] as String?,
        url = json['url'] as String?,
        imageUrl = json['image_url'] as String?,
        language = json['language'] as String?,
        publishedAt = json['published_at'] as String?,
        source = json['source'] as String?,
        relevanceScore = json['relevance_score'],
        entities = json['entities'] as List?,
        similar = (json['similar'] as List?)
            ?.map((dynamic e) => Similar.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'description': description,
        'keywords': keywords,
        'snippet': snippet,
        'url': url,
        'image_url': imageUrl,
        'language': language,
        'published_at': publishedAt,
        'source': source,
        'relevance_score': relevanceScore,
        'entities': entities,
        'similar': similar?.map((e) => e.toJson()).toList()
      };
}

class Similar {
  final String? uuid;
  final String? title;
  final String? description;
  final String? keywords;
  final String? snippet;
  final String? url;
  final String? imageUrl;
  final String? language;
  final String? publishedAt;
  final String? source;
  final dynamic relevanceScore;
  final List<dynamic>? entities;

  Similar({
    this.uuid,
    this.title,
    this.description,
    this.keywords,
    this.snippet,
    this.url,
    this.imageUrl,
    this.language,
    this.publishedAt,
    this.source,
    this.relevanceScore,
    this.entities,
  });

  Similar.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        keywords = json['keywords'] as String?,
        snippet = json['snippet'] as String?,
        url = json['url'] as String?,
        imageUrl = json['image_url'] as String?,
        language = json['language'] as String?,
        publishedAt = json['published_at'] as String?,
        source = json['source'] as String?,
        relevanceScore = json['relevance_score'],
        entities = json['entities'] as List?;

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'title': title,
        'description': description,
        'keywords': keywords,
        'snippet': snippet,
        'url': url,
        'image_url': imageUrl,
        'language': language,
        'published_at': publishedAt,
        'source': source,
        'relevance_score': relevanceScore,
        'entities': entities
      };
}
