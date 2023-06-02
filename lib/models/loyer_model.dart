import 'package:emoraa/models/payment_model.dart';

class LoyerModel {
  final int? id;
  final int ownerId;
  final bool? state;
  final String firstname;
  final String lastname;
  final String phone;
  final String identify;
  final String? address;
  final String date;
  final String? avatar;
  final int? houseId;
  final List<HousePaymentModel>? paymentIds;

  LoyerModel(
      {this.id,
      required this.ownerId,
      this.state,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.identify,
      required this.date,
      this.avatar,
      this.address,
      this.houseId,
      this.paymentIds});

  Map<String, dynamic> toMap() => {
        'owner_id': ownerId,
        'firstname': firstname,
        'lastname': lastname,
        'date': date.toString(),
        'avatar': avatar,
        'address': address,
        'state': state,
        'identify': identify,
        'phone': phone,
        'house_id': houseId,
        'payment_ids': paymentIds,
      };
  factory LoyerModel.fromString(Map<String, dynamic> value) => LoyerModel(
        ownerId: value['owner_id'],
        firstname: value['firstname'],
        lastname: value['lastname'],
        date: value['date'],
        avatar: value['avatar'],
        identify: value['identify'],
        phone: value['phone'],
        address: value['address'],
        state: value['state'],
        houseId: value['house_id'],
        paymentIds: value['payment_ids'],
      );
}
