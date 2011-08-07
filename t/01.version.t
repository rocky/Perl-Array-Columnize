#!/usr/bin/env perl -w
# -*- Perl -*-
use Test::More;
use lib '../lib';
use Test::More tests => 2;
note( "Testing Array::Columnize::VERSION" );
BEGIN {
use_ok( Array::Columnize );
}

ok(defined($Array::Columnize::VERSION), 
   "\$Array::Columnize::VERSION number is set");

