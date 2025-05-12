String getShortTitle(String title) {
  print('in title function');
  final words = title.trim().split(' ');
  print(words);
  if (words.length < 2) {
    print(title);
    return title;
  } else {
    print(words.take(2).join(' '));
    return words.take(2).join(' ');
  }
}
