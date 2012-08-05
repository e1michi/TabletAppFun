#!/usr/local/bin/perl

require 'data_handler.pl';

my @fields = ( 'abc', "def" );
printf("[%s, %s]\n", $fields[0], $fields[1]);

my $status = dh_add( 'test', @fields );
die "error" unless ($status);

@fields = dh_get( 'test', 1000 );
die "error" if (@fields);

@fields = dh_get( 'test', 5 );
die "error" unless (@fields);

printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);

my @data = dh_get_all('test');
die "error" unless (@data);

foreach my $tmp (@data) {
	@fields = @$tmp;
    printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);
}
