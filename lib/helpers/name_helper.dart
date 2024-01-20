String getGoodName(String firstName, String? lastName) {
  String text = "";
  text = "${firstName[0].toUpperCase()}${firstName.substring(1)}";
  if (lastName != null) {
    text += " ${lastName[0].toUpperCase()}${lastName.substring(1)}";
  }
  return text;
}
