class UserModel{
  static const String collectionName="user";
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  UserModel({required this.id,required this.firstName,required this.lastName,required this.email});
  UserModel.fromFireStore(Map<String,dynamic> data){
    id=data['id'];
    firstName=data["firstName"];
    lastName=data['lastName'];
    email=data['email'];
  }
  Map<String,dynamic> toFireStore(){
    return{
      "id":id,
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
    };
  }


}