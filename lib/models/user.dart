class User {
  String? id;
  String? name;
  String? contact;
  String? address;
  String? email;
  String? password;

  User(
      {this.id,
        this.name,
        this.contact,
        this.address,
        this.email,
        this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
