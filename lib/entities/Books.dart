import 'dart:convert';

class Books {
  List<BooksDatum>? books;
  Meta? meta;
  BooksLinks? links;

  Books({
    this.books,
    this.meta,
    this.links,
  });

  factory Books.fromRawJson(String str) => Books.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Books.fromJson(Map<String, dynamic> json) => Books(
    books: json["data"] == null ? [] : List<BooksDatum>.from(json["data"]!.map((x) => BooksDatum.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    links: json["links"] == null ? null : BooksLinks.fromJson(json["links"]),
  );

  List<BooksDatum>? get booksList => books;

  Map<String, dynamic> toJson() => {
    "data": books == null ? [] : List<dynamic>.from(books!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
    "links": links?.toJson(),
  };
}

class BooksDatum {
  String? id;
  String? type;
  Attributes? attributes;
  Relationships? relationships;
  DatumLinks? links;

  BooksDatum({
    this.id,
    this.type,
    this.attributes,
    this.relationships,
    this.links,
  });

  factory BooksDatum.fromRawJson(String str) => BooksDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksDatum.fromJson(Map<String, dynamic> json) => BooksDatum(
    id: json["id"],
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
    relationships: json["relationships"] == null ? null : Relationships.fromJson(json["relationships"]),
    links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes?.toJson(),
    "relationships": relationships?.toJson(),
    "links": links?.toJson(),
  };
}

class Attributes {
  String? slug;
  String? author;
  String? cover;
  String? dedication;
  int? pages;
  DateTime? releaseDate;
  String? summary;
  String? title;
  String? wiki;

  Attributes({
    this.slug,
    this.author,
    this.cover,
    this.dedication,
    this.pages,
    this.releaseDate,
    this.summary,
    this.title,
    this.wiki,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    slug: json["slug"],
    author: json["author"],
    cover: json["cover"],
    dedication: json["dedication"],
    pages: json["pages"],
    releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
    summary: json["summary"],
    title: json["title"],
    wiki: json["wiki"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "author": author,
    "cover": cover,
    "dedication": dedication,
    "pages": pages,
    "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
    "summary": summary,
    "title": title,
    "wiki": wiki,
  };
}

class DatumLinks {
  String? self;

  DatumLinks({
    this.self,
  });

  factory DatumLinks.fromRawJson(String str) => DatumLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    self: json["self"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
  };
}

class Relationships {
  Chapters? chapters;

  Relationships({
    this.chapters,
  });

  factory Relationships.fromRawJson(String str) => Relationships.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
    chapters: json["chapters"] == null ? null : Chapters.fromJson(json["chapters"]),
  );

  Map<String, dynamic> toJson() => {
    "chapters": chapters?.toJson(),
  };
}

class Chapters {
  List<ChaptersDatum>? data;

  Chapters({
    this.data,
  });

  factory Chapters.fromRawJson(String str) => Chapters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chapters.fromJson(Map<String, dynamic> json) => Chapters(
    data: json["data"] == null ? [] : List<ChaptersDatum>.from(json["data"]!.map((x) => ChaptersDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChaptersDatum {
  String? id;
  Type? type;

  ChaptersDatum({
    this.id,
    this.type,
  });

  factory ChaptersDatum.fromRawJson(String str) => ChaptersDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChaptersDatum.fromJson(Map<String, dynamic> json) => ChaptersDatum(
    id: json["id"],
    type: typeValues.map[json["type"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": typeValues.reverse[type],
  };
}

enum Type {
  CHAPTER
}

final typeValues = EnumValues({
  "chapter": Type.CHAPTER
});

class BooksLinks {
  String? self;
  String? current;

  BooksLinks({
    this.self,
    this.current,
  });

  factory BooksLinks.fromRawJson(String str) => BooksLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksLinks.fromJson(Map<String, dynamic> json) => BooksLinks(
    self: json["self"],
    current: json["current"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "current": current,
  };
}

class Meta {
  Pagination? pagination;
  String? copyright;
  DateTime? generatedAt;

  Meta({
    this.pagination,
    this.copyright,
    this.generatedAt,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    copyright: json["copyright"],
    generatedAt: json["generated_at"] == null ? null : DateTime.parse(json["generated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination?.toJson(),
    "copyright": copyright,
    "generated_at": generatedAt?.toIso8601String(),
  };
}

class Pagination {
  int? current;
  int? records;

  Pagination({
    this.current,
    this.records,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    current: json["current"],
    records: json["records"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "records": records,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
