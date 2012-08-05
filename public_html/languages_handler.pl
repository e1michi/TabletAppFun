#!/usr/local/bin/perl

require 'data_handler.pl';

sub content_add {
	my ( @fields ) = @_;

    return dh_add($languages_data_file, @fields);
}

sub content_delete {
	my ( $id ) = @_;

    return dh_delete($languages_data_file, $id);
}

sub content_update {
	my ( @fields ) = @_;

    return dh_update($languages_data_file, @fields);
}

sub content_get_all {
    return dh_get_all($languages_data_file);
}

sub content_get {
	my ( $id ) = @_;

    return dh_get($languages_data_file, $id);
}
