=head1 DESCRIPTION

# Sets constant ARRAY::Columnize::VERSION, the version number of this
# package.

=cut
package Array::Columnize;
use strict;
use warnings;

use constant VERSION => '0.3.5'; # 0.3.5 to match initial Ruby version

if (__FILE__ eq $0 ) {
    print Array::Columnize::VERSION, "\n";
}

1;
