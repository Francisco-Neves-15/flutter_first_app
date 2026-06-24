void main(){

  int age = 15;
  String category;

  if (age >= 0 && age <= 12) {
    category = 'Child';
  } else if (age >= 13 && age <= 19) {
    category = 'Teenager';
  } else if (age >= 20 && age <= 64) {
    category = 'Adult';
  } else if (age >= 65) {
    category = 'Senior';
  } else {
    category = 'Invalid age';
  }

  switch (category) {
    case 'Child':
      print('Category: Child');
      break;
    case 'Teenager':
      print('Category: Teenager');
      break;
    case 'Adult':
      print('Category: Adult');
      break;
    case 'Senior':
      print('Category: Senior');
      break;
    default:
      print('Invalid age');
  }

}
