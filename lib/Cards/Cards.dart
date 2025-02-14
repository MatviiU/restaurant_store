
class Cards{
  int? idCard;
  int? cardNumber;
  String? expireDate;
  int? cvv;
  String? cardUserName;
  String? login;

  Cards({
    this.idCard,
    this.cardNumber,
    this.expireDate,
    this.cvv,
    this.cardUserName,
    this.login,
  });


  factory Cards.fromMap(Map<String, dynamic> cardJson) =>
      Cards(
        idCard: cardJson['IDCard'],
        cardNumber: cardJson['CardNumber'],
        expireDate: cardJson['ExpireDate'],
        cvv: cardJson['CVV'],
        cardUserName: cardJson['CardUserName'],
        login: cardJson['Login'],
      );

  Map<String, dynamic> toMap() => {
    'IDCard': idCard,
    'CardNumber': cardNumber,
    'ExpireDate': expireDate,
    'CVV': cvv,
    'CardUserName': cardUserName,
    'Login': login,
  };

  Cards parseFirebaseModel(record, String id){
    Map<String, dynamic> attributes  = {
      'IDCard': 0,
      'CardNumber': 0,
      'ExpireDate': '',
      'CVV': 0,
      'CardUserName': '',
      'Login': '',
    };

    record.forEach((key, value) => {attributes[key] = value});
    Cards cards = Cards(
      idCard: attributes['IDCard'],
      cardNumber: attributes['CardNumber'],
      expireDate: attributes['ExpireDate'],
      cvv: attributes['CVV'],
      cardUserName: attributes['CardUserName'],
      login: attributes['Login'],
    );

    return cards;
  }

}