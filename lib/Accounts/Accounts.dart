
class Accounts{
  String? idAccount;
  String? login;
  String? password;

  Accounts({
    this.idAccount,
    this.login,
    this.password,
  });

  static String? loggedLogin;

  factory Accounts.fromMap(Map<String, dynamic> accountJson) =>
      Accounts(
          idAccount: accountJson['IDAccount'],
          login: accountJson['Login'],
          password: accountJson['Password'],
      );

  Map<String, dynamic> toMap() => {
    'IDAccount': idAccount,
    'Login': login,
    'Password': password,
  };

  Accounts parseFirebaseModel(record, String id){
    Accounts accounts = new Accounts();
    try {
      Map<String, dynamic> attributes = {
        'Password': '',
      };

      record.forEach((key, value) => {attributes[key] = value});
      accounts = Accounts(
        idAccount: id,
        password: attributes['Password'],
      );
    }
    catch(e)
    {
    print("NullPointerException caught");
    }
    return accounts;
  }
}