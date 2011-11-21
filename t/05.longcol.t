#!/usr/bin/env perl
# -*- Perl -*-
use warnings;
use Test::More;
use rlib '../lib';
use Test::More;

BEGIN {
    use_ok( Array::Columnize::columnize );
}

use Array::Columnize::columnize;

note( "Testing when width is less than one of the items" );
my $data = ["what's", "upppppppppppppppppp"];
is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				arrange_vertical => 0}),
    "what's\nupppppppppppppppppp", 
    );

done_testing();
