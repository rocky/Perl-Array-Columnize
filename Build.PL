#  Copyright (C) 2011 Rocky Bernstein <rockycpan.org>
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
use ExtUtils::PkgConfig;
use Config;

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
    release_status      => 'stable',
    requires => {
	'ExtUtils::PkgConfig'     => '1.03',
        'Test::More'              => 0,
        'version'                 => 0,
	'Module::Build'           => 0.38
    },
    sign                => 1,
    );

$builder->create_build_script();
