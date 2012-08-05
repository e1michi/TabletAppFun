#!/usr/local/bin/perl

sub sf_array_sort {
	my ( @data, $position, $direction ) = @_;

	my @data;
	if ( $direction == 1 ) {
		@data = sort { $a->[$position] <=> $b->[$position] } @data;
	}
	elsif ( $direction == 2 ) {
		@data = sort { $b->[$position] <=> $a->[$position] } @data;
	}
	elsif ( $direction == 3 ) {
		@data = sort { $a->[$position] cmp $b->[$position] } @data;
	}
	elsif ( $direction == 4 ) {
		@data = sort { $b->[$position] cmp $a->[$position] } @data;
	}

	return @data;
}
