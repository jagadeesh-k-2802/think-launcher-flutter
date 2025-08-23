class Folder {
  final String id;
  final String name;
  final List<String> appPackageNames;
  final int order;

  const Folder({
    required this.id,
    required this.name,
    required this.appPackageNames,
    this.order = 9999999999999999, // To Keep it at last
  });

  Folder copyWith({
    String? name,
    List<String>? appPackageNames,
    int? order,
  }) {
    return Folder(
      id: id,
      name: name ?? this.name,
      appPackageNames: appPackageNames ?? this.appPackageNames,
      order: order ?? this.order,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'appPackageNames': appPackageNames,
      'order': order,
    };
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'] as String,
      name: json['name'] as String,
      appPackageNames: List<String>.from(json['appPackageNames'] as List),
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }
}
