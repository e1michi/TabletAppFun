#!/usr/local/bin/perl

require 'environ.pl' unless $environ;

sub array_position {
	my ( $key, @array ) = @_;

	my $idx = 0;
	foreach (@array) {
		if (/^$key$/) {
			last;
		}
		$idx++;
	}

	return $idx if ( $idx < @array );
	return -1;
}

sub logger {
	my ( $level, $msg ) = @_;

	my $logging_level = array_position( $level, @log_level_keys );
	return if ( $logging_level < 0 );
	return if ( $logging_level > $logging );

	my $t = time();
	my ( $sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst ) =
	  localtime($t);

	open( LOGGER_OUT, ">> $log_dir/$log_filename" );

	printf( LOGGER_OUT "%4d-%02d-%02dT%02d:%02d:%02d+9:00 %s %s\n",
		$year + 1900,
		$mon + 1, $mday, $hour, $min, $sec, $log_level{$level}, $msg
	);

	close(LOGGER_OUT);
}

sub logger_error {
	my ($msg) = @_;

	logger( 'error', $msg );
}

sub logger_warn {
	my ($msg) = @_;

	logger( 'warn', $msg );
}

sub logger_info {
	my ($msg) = @_;

	logger( 'info', $msg );
}

sub logger_config {
	my ($msg) = @_;

	logger( 'config', $msg );
}

sub logger_debug {
	my ($msg) = @_;
	
	logger( 'debug', $msg );
}

sub write_http_header {
	printf("Content-Type: text/html\n");
	printf("\n");
}

1;
