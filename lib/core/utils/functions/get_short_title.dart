String getShortTitle(String title) {
  final words = title.trim().split(' ');
  if (words.length < 2) {
    return title;
  } else {
    return words.take(2).join(' ');
  }
}
