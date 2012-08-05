#!/usr/local/bin/perl

print "Content-type: text/html\n";
print "\n";
print "<pre>\n";
print "Hello World\n";

open(FILE, "/bin/sh kaz.sh |");
while (<FILE>){
  print;
}
close(FILE);

print "</pre>\n";
