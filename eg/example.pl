#!/usr/bin/env perl
use Array::Columnize;

# Simple data example 
print columnize(['a','b','c','d'], {displaywidth=>4}), "\n";
# produces:
#
#    a  c
#    b  d

# With numeric data

my $data_ref = [80..120];
print columnize($data_ref, {ljust => 0}), "\n" ;

# produces:
#
#     80  83  86  89  92  95   98  101  104  107  110  113  116  119
#     81  84  87  90  93  96   99  102  105  108  111  114  117  120
#     82  85  88  91  94  97  100  103  106  109  112  115  118

# while:

print columnize($data_ref, {ljust => 0, arrange_vertical => 0}) ;

# produces:
#
#     80   81   82   83   84   85   86   87   88   89
#     90   91   92   93   94   95   96   97   98   99
#    100  101  102  103  104  105  106  107  108  109
#    110  111  112  113  114  115  116  117  118  119
#    120

