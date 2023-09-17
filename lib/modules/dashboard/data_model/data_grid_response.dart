// To parse this JSON data, do
//
//     final dataGridResponse = dataGridResponseFromJson(jsonString);

import 'dart:convert';

List<DataGridResponse> dataGridResponseFromJson(String str) => List<DataGridResponse>.from(json.decode(str).map((x) => DataGridResponse.fromJson(x)));

String dataGridResponseToJson(List<DataGridResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataGridResponse {
    int id;
    String title;
    String itemId;
    bool active;
    DateTime? date;
    bool overdue;
    ItemType1? itemType1;
    ItemType1? itemType2;
    List<ItemType1>? level1;
    List<ItemType1>? level2;
    Status status;

    DataGridResponse({
        required this.id,
        required this.title,
        required this.itemId,
        required this.active,
        required this.date,
        required this.overdue,
        this.itemType1,
        this.itemType2,
        this.level1,
        this.level2,
        required this.status,
    });

    factory DataGridResponse.fromJson(Map<String, dynamic> json) => DataGridResponse(
        id: json["id"],
        title: json["title"],
        itemId: json["item_id"],
        active: json["active"],
        date: DateTime.tryParse(json["date"] ?? ""),
        overdue: json["overdue"],
        itemType1: json["item_type1"] == null ? null : ItemType1.fromJson(json["item_type1"]),
        itemType2: json["item_type2"] == null ? null : ItemType1.fromJson(json["item_type2"]),
        level1: json["level1"] == null ? [] : List<ItemType1>.from(json["level1"]!.map((x) => ItemType1.fromJson(x))),
        level2: json["level2"] == null ? [] : List<ItemType1>.from(json["level2"]!.map((x) => ItemType1.fromJson(x))),
        status: Status.fromJson(json["status"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "item_id": itemId,
        "active": active,
        "date": date,
        "overdue": overdue,
        "item_type1": itemType1?.toJson(),
        "item_type2": itemType2?.toJson(),
        "level1": level1 == null ? [] : List<dynamic>.from(level1!.map((x) => x.toJson())),
        "level2": level2 == null ? [] : List<dynamic>.from(level2!.map((x) => x.toJson())),
        "status": status.toJson(),
    };
}

class ItemType1 {
    String? value;
    String? color;

    ItemType1({
        this.value,
        this.color,
    });

    factory ItemType1.fromJson(Map<String, dynamic> json) => ItemType1(
        value: json["value"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "color": color,
    };
}

class Status {
    int currentCount;
    int totalCount;

    Status({
        required this.currentCount,
        required this.totalCount,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        currentCount: json["current_count"],
        totalCount: json["total_count"],
    );

    Map<String, dynamic> toJson() => {
        "current_count": currentCount,
        "total_count": totalCount,
    };
}
