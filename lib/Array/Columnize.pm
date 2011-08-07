#!/usr/bin/env perl 
# Module to format an Array as an Array of String aligned in columns.
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
use warnings;
use lib '..';
use Array::Columnize::version;
use Array::Columnize::columnize;
