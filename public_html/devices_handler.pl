#!/usr/local/bin/perl

require 'data_handler.pl';

sub content_add {
	my ( @fields ) = @_;

    return dh_add($devices_data_file, @fields);
}

sub content_delete {
	my ( $id ) = @_;

    return dh_delete($devices_data_file, $id);
}

sub content_update {
	my ( @fields ) = @_;

    return dh_update($devices_data_file, @fields);
}

sub content_get_all {
    return dh_get_all($devices_data_file);
}

sub content_get {
	my ( $id ) = @_;

    return dh_get($devices_data_file, $id);
}
