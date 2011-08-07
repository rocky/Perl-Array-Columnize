#!/usr/bin/env perl
# -*- Perl -*-
use warnings;
use Test::More;
use lib '../lib';
use Test::More;

note( "Testing Array::Columnize::cell_size" );
BEGIN {
    use_ok( Array::Columnize::columnize );
}

use Array::Columnize::columnize;
my $line = 'require [1;29m"[0m[1;37mirb[0m[1;29m"[0m';
is Array::Columnize::cell_size($line, 1), length('require "irb"');
is Array::Columnize::cell_size($line, 0), length($line);
done_testing();
