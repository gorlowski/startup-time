import 'dart:io'; 

// I do not know why, but as-of Dart version 2.10.4, if we do not add an explicit
// exit(0) then the executable will hang for about 1 second if we try to execute
// it repeatedly with ./run. The explicit exit(0) seems to eliminate this issue,
// but it may be worth exploring why this is happening to see if there is an
// issue with the internals of run.c that is causing this.
void main(List<String> arguments) {
  print('Hello World!');
  exit(0);
}
