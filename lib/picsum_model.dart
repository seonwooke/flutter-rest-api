class PicsumModel {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  PicsumModel({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  /* 방법1 */
  // PiscumModel.fromJson(Map<String, dynamic> json)
  //     : id = json["id"],
  //       author = json["author"],
  //       width = json["width"],
  //       height = json["height"],
  //       url = json["url"],
  //       downloadUrl = json["download_url"];

  /* 방법2 */
  factory PicsumModel.fromJson(Map<String, dynamic> json) {
    return PicsumModel(
      id: json["id"],
      author: json["author"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      downloadUrl: json["download_url"],
    );
  }
}
