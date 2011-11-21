#!/usr/bin/env perl 
# See doc in Array::Columnize
package Array::Columnize;
use strict;
use warnings;
use lib '../..';
use POSIX;
use Array::Columnize::options;

# Return the length of String +cell+. If Boolean +term_adjust+ is true,
# ignore terminal sequences in +cell+.
sub cell_size($$) {
    my ($cell, $term_adjust) = @_;
    $cell =~ s/\e\[.*?m//g if $term_adjust;
    return length($cell);
}

# Return a list of strings with embedded newlines (\n) as a compact
# set of columns arranged horizontally or vertically.
#
# For example, for a line width of 4 characters (arranged vertically):
#     ['1', '2,', '3', '4'] => '1  3\n2  4'

# or arranged horizontally:
#     ['1', '2,', '3', '4'] => '1  2\n3  4'
#     
# Each column is only as wide possible, no larger than
# +displaywidth'.  If +list+ is not an array, the empty string, '',
# is returned. By default, columns are separated by two spaces - one
# was not legible enough. Set +colsep+ to adjust the string separate
# columns. If +arrange_vertical+ is set false, consecutive items
# will go across, left to right, top to bottom.

sub columnize($;$) {
    my($aref, $opts) = @_;
    my @l = @$aref;
    
    # Some degenerate cases
    # FIXME test for arrayness
    # return '' if  $aref is not an array
    return "<empty>" if 0 == scalar(@l);
    $opts = {} unless $opts;
    merge_config $opts;
    my %opts = %$opts;
    return sprintf("%s%s%s", 
		   $opts{array_prefix}, $opts{lineprefix}, 
		    $l[0], $opts{array_suffix}) if 1 == scalar(@l);

    my ($nrows, $ncols) = (0, 0);  # Make nrows, ncols have more global scope
    my @colwidths = ();     # Same for colwidths

    if ($opts{displaywidth} - length($opts{lineprefix}) < 4) {
	$opts{displaywidth} = length($opts{lineprefix}) + 4;
    } else {
	$opts{displaywidth} -= length($opts{lineprefix})
    }
    if ($opts{arrange_vertical}) {
	my $array_index = sub ($$$) { 
	    my ($num_rows, $row, $col) = @_;
	    ($num_rows * $col) + $row
	};
	# Try every row count from 1 upwards
	for (my $_nrows=1; $_nrows < scalar @l; $_nrows++) {
	    $nrows = $_nrows;
	    $ncols = POSIX::ceil((scalar(@l)) / $nrows);
	    @colwidths = ();
	    my $totwidth = -length($opts{colsep});
	    
	    for (my $col=0; $col < $ncols; $col++) {
		# get max column width for this column
		my $colwidth = 0;
		for (my $row=0; $row < $nrows; $row++) {
		    my $i = $array_index->($nrows, $row, $col);
		    last if ($i >= scalar(@l));
		    my $try_width = cell_size($l[$i], $opts{term_adjust});
		    $colwidth =  $try_width if $try_width > $colwidth;
		}
		push(@colwidths, $colwidth);
		$totwidth += $colwidth + length($opts{colsep});
		if ($totwidth > $opts{displaywidth}) {
		    $ncols = $col;
		    last;
		}
	    }
	    last if ($totwidth <= $opts{displaywidth});
	}
	# The smallest number of rows computed and the max widths for
	# each column has been obtained.  Now we just have to format
	# each of the rows.
	my @s = ();
	for (my $row=0; $row < $nrows; $row++) {
	    my @texts = ();
	    my $x;
	    for (my $col=0; $col < $ncols; $col++) {
		my $i = $array_index->($nrows, $row, $col);
		if ($i >= scalar(@l)) {
		    $x = '';
		} else {
		    $x = $l[$i];
		}
		push @texts, $x;
	    }
	    pop(@texts) while (scalar(@texts) > 0 && $texts[-1] eq '');
	    if (scalar(@texts) > 0) {
		for (my $col=0; $col < scalar(@texts); $col++) {
		    my $fmt = sprintf("%%%s$colwidths[$col]s",
				      ($opts{ljust} ? '-': '')); 
		    $texts[$col] = sprintf($fmt, $texts[$col]);
		}
		push(@s, sprintf("%s%s", $opts{lineprefix}, 
				 join($opts{colsep}, @texts)));
	    }
	}
	return join("\n", @s);
    } else {
    	my $array_index = sub ($$$) {
	    my ($num_rows, $row, $col) = @_;
	    $ncols * ($row-1) + $col;
	};
    	# Try every column count from size downwards.
    	my ($totwidth, $i, $rounded_size) = (0, 0, 0);
        for (my $_ncols=scalar(@l); $_ncols >= 1; $_ncols--) {
	    $ncols = $_ncols;
	    # Try every row count from 1 upwards
	    my $min_rows = POSIX::ceil((scalar(@l)+$ncols-1) / $ncols);
	    for (my $_nrows=$min_rows; $_nrows <= scalar(@l); $_nrows++) {
		$nrows = $_nrows;
		$rounded_size = $nrows * $ncols;
		@colwidths = ();
		$totwidth = -length($opts{colsep});
		my ($colwidth, $row) = (0,0);
		for (my $col=0; $col < $ncols; $col++) {
		    # get max column width for this column
		    for (my $_row=1; $_row <= $nrows; $_row++) {
		    	$row = $_row;
		    	$i = $array_index->($nrows, $row, $col);
		    	last if $i >= scalar(@l);
			my $try_size = cell_size($l[$i], 
						 $opts{term_adjust});
			$colwidth = $try_size if $try_size > $colwidth;
		    }
		    push @colwidths, $colwidth;
		    $totwidth += $colwidth + length($opts{colsep});
		    last if ($totwidth > $opts{displaywidth});
		}
		if ($totwidth <= $opts{displaywidth}) {
		    # Found the right nrows and ncols
		    $nrows  = $row;
		    last;
		}
		elsif ($totwidth >= $opts{displaywidth}) {
		    # Need to reduce ncols
		    last;
		}
	    }
	    last if ($totwidth <= $opts{displaywidth} && $i >= $rounded_size-1);
	}
	$nrows = scalar(@l) if $ncols == 1;

	# The smallest number of rows computed and the
	# max widths for each column has been obtained.
	# Now we just have to format each of the
	# rows.
	my @s = ();
	my $prefix = $opts{array_prefix} = '' ? 
	    $opts{lineprefix} : $opts{array_prefix}; 
	for (my $row=1; $row <= $nrows; $row++) {
	    my @texts = ();
	    my $x;
	    for (my $col=0; $col < $ncols; $col++) {
		my $i = $array_index->($nrows, $row, $col);
		if ($i >= scalar(@l)) {
		    last;
		} else {
		    $x = $l[$i];
		}
		push @texts, $x;
	    }
	    for (my $col=0; $col < scalar(@texts); $col++) {
		my $fmt = sprintf("%%%s$colwidths[$col]s",
				  ($opts{ljust} ? '-': '')); 
		$texts[$col] = sprintf($fmt, $texts[$col]) if $ncols != 1;
	    }
	    push(@s, sprintf("%s%s", $opts{lineprefix}, 

			     join($opts{colsep}, @texts))) if scalar(@texts);

	}
	return join("\n", @s);
    }
}


# Demo it
unless (caller) {

    my @ary = qw(bibrons golden madascar leopard mourning suras tokay);
    print columnize(\@ary, {displaywidth => 18});

    my $line = 'require [1;29m"[0m[1;37mirb[0m[1;29m"[0m';
    print cell_size($line, 1), "\n";
    print cell_size($line, 0), "\n";

    print columnize(['hi']), "\n";
    print columnize([]), "\n";

    for my $tuple ([4, 4], [4, 7], [100, 180]) {
	my @data = ($tuple->[0]..$tuple->[1]);
	print columnize(\@data, {colsep =>'  ', arrange_vertical=>0}), "\n";
	print '------------------------';
	print columnize(\@data, {colsep =>'  ', arrange_vertical=>1}), "\n";
	print '========================';
    }
    print columnize(["a", 2, "c"], {displaywidth => 10, colsep => ', '}), "\n";
    print columnize(["oneitem"]);
    print columnize(["one", "two", "three"]);
    my @data = ("one",       "two",         "three",
		"for",       "five",        "six",
		"seven",     "eight",       "nine",
		"ten",       "eleven",      "twelve",
		"thirteen",  "fourteen",    "fifteen",
		"sixteen",   "seventeen",   "eightteen",
		"nineteen",  "twenty",      "twentyone",
		"twentytwo", "twentythree", "twentyfour",
		"twentyfive","twentysix",   "twentyseven");
	    
    print columnize(\@data);
}

1;
