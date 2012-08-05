#!/usr/local/bin/perl

require 'contents_handler.pl';

my @fields = ( 'abc', "def" );
printf("[%s, %s]\n", $fields[0], $fields[1]);

my $id = content_add(@fields);
die 'error' unless $id;

@fields = content_get(5);
printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);

my @records = content_get_all();
foreach my $data (@records) {
	@fields = @$data;
	printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);
}
