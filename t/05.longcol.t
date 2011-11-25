#!/usr/bin/env perl
# -*- Perl -*-
use warnings;
use Test::More;
use rlib '../lib';
use Test::More;
use Array::Columnize::columnize

note( "Testing when width is less than one of the items" );
my $data = ["what's", "upppppppppppppppppp"];
is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				arrange_vertical => 0}),
    "what's\nupppppppppppppppppp", 
    );

is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				ljust=>1,
				arrange_vertical => 1}),
    "what's\nupppppppppppppppppp", 
    );

is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				ljust=>0,
				arrange_vertical => 1}),
    "what's\nupppppppppppppppppp", 
    );


$data = ["whaaaaaat's", "up"];
is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				ljust=>0,
				arrange_vertical => 0}),
   "whaaaaaat's\n         up"
    );

$data = ["whaaaaaat's", "up"];
is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				ljust=>1,
				arrange_vertical => 0}),
   "whaaaaaat's\nup"
    );

$data = ["whaaaaaat's", "up"];
is(Array::Columnize::columnize($data,
                               {displaywidth => 7,
				ljust=>1,
				arrange_vertical => 1}),
   "whaaaaaat's\nup"
    );

done_testing();
