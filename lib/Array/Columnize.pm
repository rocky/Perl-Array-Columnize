# Format an Array as an Array of String aligned in columns.
#
# == Summary
# Display a list of strings as a compact set of columns.
#
#   For example, for a line width of 4 characters (arranged vertically):
#        ['1', '2,', '3', '4'] => '1  3\n2  4\n'
#   
#    or arranged horizontally:
#        ['1', '2,', '3', '4'] => '1  2\n3  4\n'
#        
# Each column is only as wide as necessary.  By default, columns are
# separated by two spaces. Options are avalable for setting
# * the display width
# * the column separator
# * the line prefix
# * whether to ignore terminal codes in text size calculation
# * whether to left justify text instead of right justify
#
# == License 
#
# Columnize is copyright (C) 2011 Rocky Bernstein <rocky@cpan.org>
#
# All rights reserved.  You can redistribute and/or modify it under
# the same terms as Perl.
#
# Adapted from the routine of the same name in Ruby.

package Array::Columnize;
use strict;
use Exporter;
use warnings;
use lib '..';

use Array::Columnize::columnize;
use vars qw(@ISA @EXPORT @EXPORT_OK $VERSION);
@ISA = qw/ Exporter /;
@EXPORT = qw(columnize);

use version; $VERSION = '0.4.1dev';

if (__FILE__ eq $0 ) {
    print "This is version: $Array::Columnize::VERSION\n";
    print columnize([1,2,3,4], {displaywidth=>4}), "\n";
}

1;

=encoding utf8

=head1 NAME

Array::Columnize - arrange list data in columns.

=head1 SYNOPSIS

    use Array::Columnize;
    print columnize($array_ref, $optional_hash_or_hash_ref), "\n";

=head1 DESCRIPTION

In showing long lists, sometimes one would prefer to see the values
arranged and aligned in columns. Some examples include listing methods of
an object, listing debugger commands, or showing a numeric array with data
aligned.

=head1 EXAMPLES

=head2 Simple data example 

    print columnize(['a','b','c','d'], {displaywidth=>4}), "\n";

produces:

    a  c
    b  d

=head2 With numeric data

    my $data_ref = [80..120];
    print columnize($data_ref, {ljust = 0}) ;

produces:

    80  83  86  89  92  95   98  101  104  107  110  113  116  119
    81  84  87  90  93  96   99  102  105  108  111  114  117  120
    82  85  88  91  94  97  100  103  106  109  112  115  118

while:

    print columnize($data_ref, {ljust = 0, arrange_vertical = 0}) ;

produces:

     80   81   82   83   84   85   86   87   88   89
     90   91   92   93   94   95   96   97   98   99
    100  101  102  103  104  105  106  107  108  109
    110  111  112  113  114  115  116  117  118  119
    120

=head2 With String data

    @ary = qw(bibrons golden madascar leopard mourning suras tokay);
    print columnize(\@ary, {displaywidth => 18});

produces: 

    bibrons   mourning
    golden    suras   
    madascar  tokay   
    leopard 

    puts columnize \@ary, {displaywidth => 18, colsep => ' | '};

produces:

    bibrons  | mourning
    golden   | suras   
    madascar | tokay   
    leopard 

=head1 AUTHOR

Rocky Bernstein, C<< rocky@cpan.org >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-array-columnize at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Array-Columnize>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Array::Columnize

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Array-Columnize>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Array-Columnize>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Array-Columnize>

=item * Search CPAN

L<http://search.cpan.org/dist/Array-Columnize>

=back

=head1 COPYRIGHT & LICENSE

Copyright (c) 2011 Rocky Bernstein.

=head2 LICENSE

Same terms as Perl.

=cut

1;

