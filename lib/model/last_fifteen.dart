class LastFifteen {
  dynamic id;
  dynamic number;
  dynamic gamesNo;
  dynamic gameId;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic name;
  dynamic gameName;
  dynamic json;
  dynamic images;

  LastFifteen({
    this.id,
    this.number,
    this.gamesNo,
    this.gameId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.gameName,
    this.json,
    this.images,
  });

  factory LastFifteen.fromJson(Map<String, dynamic> json) {
    return LastFifteen(
      id: json['id'],
      number: json['number'],
      gamesNo: json['gamesno'],
      gameId: json['gameid'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'],
      gameName: json['game_name'],
      json: json['json'],
      images: json['random_card'],
    );
  }
}
