#!/usr/local/bin/perl

require 'data_handler.pl';

sub content_add {
	my ( @fields ) = @_;

    return dh_add($scenes_data_file, @fields);
}

sub content_delete {
	my ( $id ) = @_;

    return dh_delete($scenes_data_file, $id);
}

sub content_update {
	my ( @fields ) = @_;

    return dh_update($scenes_data_file, @fields);
}

sub content_get_all {
    return dh_get_all($scenes_data_file);
}

sub content_get {
	my ( $id ) = @_;

    return dh_get($scenes_data_file, $id);
}
