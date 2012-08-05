#!/usr/local/bin/perl

sub parse_cgi_requrest {
	my $contents;

	logger_info("{METHOD:$ENV{'REQUEST_METHOD'}, PATH_INFO:$ENV{'PATH_INFO'}}");

	while ( ( $key, $value ) = each(%ENV) ) {
		logger_debug("<$key:$value>");
	}

	if ( $ENV{'REQUEST_METHOD'} == 'GET' ) {
		$contents = $ENV{'QUERY_STRING'};
	}
	else {
		read( STDIN, $contents, $ENV{'CONTENT_LENGTH'} );
	}

	my $p_str;

	%cgi_params = ();
	my @key_values = split( /&/, $contents );
	foreach my $field (@key_values) {
		my @key_value = split( /=/, $field );
		$key_value[1] =~ tr/+/ /;
		$key_value[1] =~ s/%([0-9a-fA-F][0-9a-fA-F])/pack("C",hex($1))/eg;
		$cgi_params{ $key_value[0] } = $key_value[1];
		
		if ( !$p_str ) {
			$p_str = '{PARAMS =>';
		}
		else {
			$p_str = $p_str . ',';
		}
		$p_str = $p_str . " $key_value[0]:$key_value[1]";
	}

	$p_str = $p_str . '}';
	logger_info($p_str);
}

1;
