import "dart:io";

void main() {
  var x = 6;

  for (int i = 0; i <= x; i += 2) {
    for (int k = i; k < x; k += 2) {
      stdout.write(" ");
    }

    for (int j = 0; j <= i; j++) {
      stdout.write("*");
    }

    stdout.write("\n");
  }
  for (int k = 0; k < x - 5; k++) {
    stdout.write(" ");
  }
  for (int i = 1; i < x; i++) {
    if (i != x ~/ 2)
      stdout.write("H");
    else
      stdout.write(" ");
  }
  stdout.write("\n");
  for (int k = 0; k < x - 5; k++) {
    stdout.write(" ");
  }
  for (int i = 1; i < x; i++) {
    stdout.write("Z");
  }
}
