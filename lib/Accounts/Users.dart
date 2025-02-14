

class Users{
  int? idUser;
  String? fbIdUser;
  String? firstName;
  String? email;
  int? phoneNumber;
  String? street;
  int? houseNumber;
  int? apartmentNumber;
  String? zipCode;
  String? login;

  Users({
     this.idUser,
     this.fbIdUser,
     this.firstName,
     this.email,
     this.phoneNumber,
     this.street,
     this.houseNumber,
     this.apartmentNumber,
     this.zipCode,
     this.login,
  });

  static String? loggedId;

  factory Users.fromMap(Map<String, dynamic> userJson) =>
      Users(
        idUser: userJson['IDUser'],
        firstName: userJson['FirstName'],
        email: userJson['Email'],
        phoneNumber: userJson['Phone'],
        street: userJson['Street'],
        houseNumber: userJson['HouseNumber'],
        apartmentNumber: userJson['ApartmentNumber'],
        zipCode: userJson['ZIPCode'],
        login: userJson['Login'],
      );

  Map<String, dynamic> toMap() => {
    'IDUser': idUser,
    'FirstName': firstName,
    'Email': email,
    'Phone': phoneNumber,
    'Street': street,
    'HouseNumber': houseNumber,
    'ApartmentNumber': apartmentNumber,
    'ZIPCode': zipCode,
    'Login': login,
  };

  Users parseFirebaseModel(record, String id){
    Users users = new Users();
    try{
      Map<String, dynamic> attributes  = {
        'FirstName': '',
        'Email': '',
        'Phone': 0,
        'Street': '',
        'HouseNumber': 0,
        'ApartmentNumber': 0,
        'ZIPCode': '',
        'Login': '',
      };

      record.forEach((key, value) => {attributes[key] = value});
      users = Users(
        fbIdUser: id,
        firstName: attributes['FirstName'],
        email: attributes['Email'],
        phoneNumber: attributes['Phone'],
        street: attributes['Street'],
        houseNumber: attributes['HouseNumber'],
        apartmentNumber: attributes['ApartmentNumber'],
        zipCode: attributes['ZIPCode'],
        login: attributes['Login'],
      );
    }
    catch(e){
      print("NullPointerException caught");
    }
    return users;
  }
}