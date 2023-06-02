

class HousePaymentModel {
  final int? id;
  final int ownerId;
  final int amount;
  final int loyerId;
  final String date;
  final String? qrImgPath;
  final bool? state;

  HousePaymentModel({
    this.id,
    required this.ownerId,
    required this.amount,
    required this.loyerId,
    required this.date,
    this.qrImgPath,
    this.state
  });

  Map<String, dynamic> toMap() => {
        'owner_id': ownerId,
        'amount': amount,
        'loyer_id': loyerId,
        'date': date.toString(),
        'qr_img_path': qrImgPath,
        'state': state
      };
  factory HousePaymentModel.fromString(Map<String, dynamic> value) =>
      HousePaymentModel(
        ownerId: value['owner_id'],
        amount: value['amount'],
        loyerId: value['loyer_id'],
        date: value['date'],
        qrImgPath: value['qr_img_path'],
        state: value['state'] ?? false
      );
}