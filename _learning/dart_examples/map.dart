void main() {

  Map<String, dynamic> user = {
    "name": "Roberto",
    "age": 25,
  };

  print(user["name"]);

  user["city"] = "Valinhos";

  // Using forEach
  user.forEach((key, value) {
    print('$key: $value');
  });

  // Using a for loop
  for (var entry in user.entries) {
    print('${entry.key}: ${entry.value}');
  }

  // New Map
  Map<String, dynamic> transformedUser = user.map((key, value) {
    print('Key: $key, Value: $value');
    // Must return a MapEntry to build the new map
    return MapEntry(key, value);
  });

}