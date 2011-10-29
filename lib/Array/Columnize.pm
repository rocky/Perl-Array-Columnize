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

use version; $VERSION = '0.3.8dev';

if (__FILE__ eq $0 ) {
    print "This is version: $Array::Columnize::VERSION\n";
    print columnize([1,2,3,4], {displaywidth=>4}), "\n";
}

1;

=encoding utf8

=head1 NAME

Array::Columnize - arrange data in columns.

=head1 SYNOPSIS

    use Array::Columnize;

    # TODO - FILL IN.

=head1 DESCRIPTION

B<TODO> - FILL IN.

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

