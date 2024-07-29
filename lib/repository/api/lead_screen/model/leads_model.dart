import 'dart:convert';

class LeadListResponse {
  final List<LeadsModel>? data;
  final Links? links;
  final Meta? meta;

  LeadListResponse({
    this.data,
    this.links,
    this.meta,
  });

  factory LeadListResponse.fromJson(Map<String, dynamic> json) {
    return LeadListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((i) => LeadsModel.fromJson(i as Map<String, dynamic>))
          .toList(),
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((i) => i.toJson()).toList(),
      'links': links?.toJson(),
      'meta': meta?.toJson(),
    };
  }
}

class LeadsModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? status;
  final DateTime? createdAt;

  LeadsModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.status,
    this.createdAt,
  });

  factory LeadsModel.fromJson(Map<String, dynamic> json) {
    return LeadsModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'] as String?,
      next: json['next'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

class Meta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final List<PageLink>? links;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] as int?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      links: (json['links'] as List<dynamic>?)
          ?.map((i) => PageLink.fromJson(i as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links?.map((i) => i.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }
}

class PageLink {
  final String? url;
  final String? label;
  final bool? active;

  PageLink({
    this.url,
    this.label,
    this.active,
  });

  factory PageLink.fromJson(Map<String, dynamic> json) {
    return PageLink(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
