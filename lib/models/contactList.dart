class Contact {
  final String name;
  final String phone;
  final String date;

  Contact({this.name, this.phone, this.date});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
        name: json['name'], phone: json['phone'], date: json['date']);
  }

  Map<String, dynamic> toMap() =>
      {'name': this.name, 'phone': this.phone, 'date': this.date};
}
