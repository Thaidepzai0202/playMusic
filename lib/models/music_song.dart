class ModelMusic {
    DateTime createdAt;
    String title;
    String image;
    String description;
    String path;
    String id;

    ModelMusic({
        required this.createdAt,
        required this.title,
        required this.image,
        required this.description,
        required this.path,
        required this.id,
    });

    factory ModelMusic.fromJson(Map<String, dynamic> json) => ModelMusic(
        createdAt: DateTime.parse(json["createdAt"]),
        title: json["title"] ??'',
        image: json["image"],
        description: json["description"],
        path: json["path"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "title": title,
        "image": image,
        "description": description,
        "path": path,
        "id": id,
    };
}