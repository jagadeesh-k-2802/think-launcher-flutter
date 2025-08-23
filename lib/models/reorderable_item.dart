import 'package:think_launcher/models/app_info.dart';
import 'package:think_launcher/models/folder.dart';

enum ReorderableItemType {
  app,
  folder,
}

class ReorderableItem {
  final String id;
  final String name;
  final ReorderableItemType type;
  final AppInfo? appInfo;
  final Folder? folder;
  final int order; // New field to track item's order in the list

  ReorderableItem({
    required this.id,
    required this.name,
    required this.type,
    required this.order,
    this.appInfo,
    this.folder,
  });

  factory ReorderableItem.fromApp(AppInfo app, {required int order}) {
    return ReorderableItem(
      id: app.packageName,
      name: app.name,
      type: ReorderableItemType.app,
      order: order,
      appInfo: app,
    );
  }

  factory ReorderableItem.fromFolder(Folder folder, {required int order}) {
    return ReorderableItem(
      id: folder.id,
      name: folder.name,
      type: ReorderableItemType.folder,
      order: order,
      folder: folder,
    );
  }

  ReorderableItem copyWith({
    String? id,
    String? name,
    ReorderableItemType? type,
    int? order,
    AppInfo? appInfo,
    Folder? folder,
  }) {
    return ReorderableItem(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      order: order ?? this.order,
      appInfo: appInfo ?? this.appInfo,
      folder: folder ?? this.folder,
    );
  }

  String get displayName {
    if (type == ReorderableItemType.app && appInfo != null) {
      return appInfo!.customName?.isNotEmpty == true
          ? appInfo!.customName!
          : appInfo!.name;
    }
    if (type == ReorderableItemType.folder && folder != null) {
      return folder!.name;
    }
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReorderableItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}