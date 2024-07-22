class MineHistoryModel {
  dynamic? id;
  dynamic userid;
  dynamic gameId;
  dynamic amount;
  dynamic multipler;
  dynamic winAmount;
  dynamic status;
  dynamic tax;
  dynamic afterTax;
  dynamic orderid;
  dynamic datetime;

  MineHistoryModel(
      {this.id,
        this.userid,
        this.gameId,
        this.amount,
        this.multipler,
        this.winAmount,
        this.status,
        this.tax,
        this.afterTax,
        this.orderid,
        this.datetime});

  MineHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    gameId = json['game_id'];
    amount = json['amount'];
    multipler = json['multipler'];
    winAmount = json['win_amount'];
    status = json['status'];
    tax = json['tax'];
    afterTax = json['after_tax'];
    orderid = json['orderid'];
    datetime = json['datetime'];
  }


}