import 'dart:math';

import 'catalog.dart';

var random = Random();

String generateRandomImage() {
  var n = random.nextInt(6) + 1;
  if (n == 1) {
    return "assets/400x200.jpeg";
  } else {
    return "assets/400x200-$n.jpeg";
  }
}

List<AddOn> allAddOns = [
  AddOn("addon-1", "Small"),
  AddOn("addon-2", "Medium"),
  AddOn("addon-3", "Large"),
  AddOn("addon-4", "Onions", price: 0.5),
  AddOn("addon-5", "Fries", price: 0.99),
  AddOn("addon-6", "Tomatoes", price: 0.25),
  AddOn("addon-7", "Sauces", price: 0.49),
  AddOn("addon-8", "BBQ Chicken", price: 1.99),
  AddOn("addon-9", "Black Olives", price: 0.5),
  AddOn("addon-10", "Capsicums", price: 1),
  AddOn("addon-11", "Mushrooms", price: 1.5),
  AddOn("addon-12", "Pineapple", price: 0.99),
  AddOn("addon-13", "Bell Peppers", price: 0.25),
  AddOn("addon-14", "Jalapeno", price: 0.5),
];

List<AddOnGroup> allAddOnGroups = [
  AddOnGroup("grp-1", "Select Your Size",
      min: 1,
      mandatory: true,
      max: 1,
      addOnIds: ["addon-1", "addon-2", "addon-3"]),
  AddOnGroup("grp-2", "Select Your Toppings", max: 3, addOnIds: [
    "addon-4",
    "addon-5",
    "addon-6",
    "addon-7",
    "addon-8",
    "addon-9",
    "addon-10"
  ]),
  AddOnGroup("grp-3", "Select Your Side",
      max: 2, addOnIds: ["addon-11", "addon-12", "addon-13", "addon-14"]),
  AddOnGroup("grp-4", "Select Your Bottom",
      max: 2,
      addOnIds: ["addon-14", "addon-13", "addon-12", "addon-11", "addon-10"]),
  AddOnGroup("grp-5", "Select Your Drink",
      max: 2, addOnIds: ["addon-7", "addon-8", "addon-9"]),
];

List<Item> demoFeaturedItems = [
  Item("item01", "Chicken Leg More than enough This is lengthy name", 25.0,
      generateRandomImage()),
  Item("item02", "Heart Smash Hash", 8.99, generateRandomImage()),
  Item("item03", "Hoppers", 4.50, generateRandomImage()),
  Item("item04", "Cozy Zoba Bowl", 17.5, generateRandomImage()),
  Item("item05", "Xone Defence", 19.99, generateRandomImage()),
];

List<Item> normalItems = [
  Item("item01", "Classic TBS Burger", 44, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item02", "Cheese Burger", 52, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-3"], calories: 345),
  Item("item03", "Mushroom & Swiss", 69, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"], calories: 200),
  Item("item04", "Margherita", 34, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item05", "Meet Lovers", 60, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item06", "Shimps", 62, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item07", "Chinati", 3.9, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item08", "Dornfleder", 2.6, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
  Item("item09", "Cabernet Franc", 5.5, generateRandomImage(),
      addOnGroupIds: ["grp-1", "grp-2", "grp-3", "grp-4"]),
];

List<Category> normalCategories = [
  Category("cat-1", "APETIZERS & SAUSAGES", generateRandomImage(),
      ["item01", "item02"]),
  Category("cat-2", "CHICKEN & RIBS", generateRandomImage(),
      ["item01", "item02", "item09", "item05"]),
  Category("cat-3", "SALADS", generateRandomImage(),
      ["item01", "item02", "item03", "item04", "item05", "item06"]),
  Category("cat-4", "PASTA & GRILLS", generateRandomImage(), ["item08"]),
  Category(
      "cat-5", "FRIES", generateRandomImage(), ["item07", "item06", "item05"]),
];
