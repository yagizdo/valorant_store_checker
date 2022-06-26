class StoreItem {
  String? uuid;
  String? displayName;
  String? displayIcon;
  String? streamedVideo;
  String? assetPath;

  StoreItem(
      {this.uuid,
        this.displayName,
        this.displayIcon,
        this.streamedVideo,
        this.assetPath});

  StoreItem.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    displayIcon = json['displayIcon'];
    streamedVideo = json['streamedVideo'];
    assetPath = json['assetPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['displayName'] = this.displayName;
    data['displayIcon'] = this.displayIcon;
    data['streamedVideo'] = this.streamedVideo;
    data['assetPath'] = this.assetPath;
    return data;
  }
}
