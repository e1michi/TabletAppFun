#!/usr/local/bin/perl

require 'environ.pl' unless $environ;

use IO::File;

#
# データファイル操作関数
#

sub dh_open {
	my ( $data_name, $mode ) = @_;

	my $filename = $data_dir . '/' . $data_name . '.' . $data_file_ext;

	return unless ( $dh_fh = IO::File->new( $filename, $mode ) );

	$SIG{0} = "dh_close";
	flock( $dh_fh, LOCK_EX );

	return $dh_fh;
}

sub dh_close {
	flock( $dh_fh, LOCK_UN );

	$dh_fh->close;
}

sub dh_array2record {
	my (@fields) = @_;

	my $str = join( $field_sep, @fields );

	return $str . "\n";
}

sub dh_record2array {
	my ($str) = @_;

	chop($str);
	my @fields = split( /$field_sep/, $str );

	return @fields;
}

sub dh_add {
	my ( $data_name, @fields ) = @_;

	return unless dh_open( $data_name, 'r+' );

	my @lines = $dh_fh->getlines();

	my $id;
	if ( @lines == 0 ) {
		$id = 1;
	}
	else {
		my @data = dh_record2array( $lines[0] );

		#printf("[%s, %s, %s]\n", $data[0], $data[1], $data[2]);
		$id = $data[0] + 1;

		#printf("%d\n", $id);
	}

	unshift( @fields, $id );

	#printf("[%s, %s, %s]\n", $fields[0], $fields[1], $fields[2]);
	my $record = dh_array2record(@fields);

	$dh_fh->seek( 0, 0 );
	print $dh_fh $record;

	foreach $line (@lines) {
		print $dh_fh $line;
	}

	dh_close();

	return $id;
}

sub dh_update {
	my ( $data_name, @fields ) = @_;

	return unless dh_open( $data_name, 'r+' );

	my @lines = ();
	foreach $line ( $dh_fh->getlines ) {
		my @data = dh_record2array($line);
		if ( $data[0] == $fields[0] ) {
			my $record = dh_array2record($fields);
			$fields[0] = 0;
		}
		else {
			my $record = dh_array2record(@data);
		}
		push( @lines, $record );
	}

	unless ( $fields[0] ) {
		dh_close;
		return;
	}

	$dh_fh->seek( 0, 0 );
	foreach $line (@lines) {
		print $dh_fh $line;
	}

	dh_close;

	return 1;
}

sub dh_delete {
	my ( $data_name, $id ) = @_;

	return unless dh_open( $data_name, 'r+' );

	my @lines = ();
	foreach $line ( $dh_fh->getlines ) {
		my @data = dh_record2array($line);
		if ( $data[0] == $id ) {
			$id = 0;
		}
		else {
			push( @lines, $line );
		}
	}

	unless ($id) {
		dh_close;
		return;
	}

	$dh_fh->seek( 0, 0 );
	foreach $line (@lines) {
		print $dh_fh $line;
	}

	dh_close;

	return 1;
}

sub dh_get {
	my ( $data_name, $id ) = @_;

	return unless dh_open( $data_name, 'r' );

	my @data;
	foreach $line ( $dh_fh->getlines ) {

		@data = dh_record2array($line);

		if ( $data[0] == $id ) {
			$id = 0;
			last;
		}
	}

	dh_close;

	if ( $id == 0 ) {
		return @data;
	}

	return;
}

sub dh_get_all {
	my ($data_name) = @_;

	return unless dh_open( $data_name, 'r' );

	my @lines = $dh_fh->getlines;

	dh_close;

	my @data = ();
	foreach $line (@lines) {
		my @fields = dh_record2array( $line );
		push( @data, \@fields );
	}

	return @data;
}
