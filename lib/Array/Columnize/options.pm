=head1 DESCRIPTION

# Array::Columnize options processing

=cut
package Array::Columnize;

sub set_config_value($$$) {
    my ($config, $field, $value) = @_;
    $config->{$field} = $value unless defined $config->{$field};
}

# Merg in default configuration options into the passed hash reference.
# Values already set in the hash are untouched.
sub merge_config(%) {
    my $config = shift;
    my @field_values = 
	( 
	  ['arrange_array', 1],
	  ['arrange_vertical', 1],
	  ['array_prefix', ''],
	  ['array_suffix', ''],
	  ['colsep', '  '],
	  ['displaywidth', $ENV{'COLUMNS'} || 80],
	  ['lineprefix', ''],
	  ['ljust', 'auto'],
	  ['term_adjust', 0]
	);
    foreach my $tuple (@field_values) {
	set_config_value($config, $tuple->[0], $tuple->[1]);
    };
}

if (__FILE__ eq $0 ) {
    my %config;
    merge_config \%config;
    use Data::Dumper;
    print Dumper(\%config), "\n";

    my $config = {
	arrange_array => 0,
	term_adjust   => 1,
	lineprefix    => '...',
	displaywidth  => 10,
	bogus         => 'yep'
    };
    print Dumper($config), "\n";
    merge_config $config;
    print Dumper($config), "\n";
}

1;