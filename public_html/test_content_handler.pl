#!/usr/local/bin/perl

require 'content_handler.pl';

@fields = ( 'abc', "def" );
printf("[%s, %s]\n", $fields[0], $fields[1]);

content_add(@fields);

@fields = content_get( 5 );
printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);

@records = content_get_all();
foreach $fields (@records) {
    printf("[%s, %s, %s]\n", $fields[0], @$fields[1], @$fields[2]);
}
