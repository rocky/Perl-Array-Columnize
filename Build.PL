#!/usr/bin/env perl
#  Copyright (C) 2011-2013 Rocky Bernstein <rocky@cpan.org>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use Module::Build;
use Config;
use File::Basename;
use File::Spec;
my $lib = File::Spec->catfile(dirname(__FILE__), 'lib');
unshift @INC, $lib;
require Array::Columnize;

my $release_status = ($Array::Columnize::VERSION =~ /_/) ?
    'testing' : 'stable';

my $builder = Module::Build->new(
    module_name         => 'Array::Columnize',
    add_to_cleanup      => [ 'Array-Columnize-*', 'tmp*'  ],
    create_makefile_pl  => 'passthrough',
    dist_abstract       =>
    'Format an Array as an Array of String aligned in columns.',
    dist_author         => 'Rocky Bernstein <rocky@cpan.org>',
    dist_version_from   => 'lib/Array/Columnize.pm',
    license             => 'gpl',
    needs_compiler      => 0,
    release_status      => $release_status,

    meta_merge => {
	resources => {
	    bugtracker  => 'https://github.com/rocky/Perl-Array-Columnize/issues',
	    repository  => 'https://github.com/rocky/Perl-Array-Columnize'
	}
    },


    configure_requires => {
	'Module::Build'           => 0,
	'perl'                    => '5.006001',
        'rlib'                    => '0.02',
	'File::Spec'              => 0,
	'File::Basename'          => 0,
    },
    build_requires => {
        'Test::More'              => 0.81,
        'rlib'                    => '0.02',
    },
    requires => {
        'version'                 => 0,
        'rlib'                    => '0.02',
    },
    sign                => ($ENV{PERL_MB_NOSIGN} ? 0 : 1),
    );

$builder->create_build_script();
