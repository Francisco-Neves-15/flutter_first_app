void main() {

  // vars

  final String name = "Roberto";
  int? age;
  double price = 19.99;
  bool active = true;

  // rules:
  // final : imutavel
  // var : mutavel
  // não declarado é mutavel

  // {rules} {type}{null safety} {name} = {value};

  // null safety = aceita "null" como valor

  print(age);
  if (age == null) {
    print("No age");
  }

}