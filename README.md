Columnize - Module to show an Array formatted as a String aligned in columns. 
============================================================================

In showing a long lists, sometimes one would prefer to see the value
arranged aligned in columns. Some examples include listing methods of
an object, listing debugger commands, or showing a numeric array with data
aligned.

Setup
-----

   use Array::Columnize;
   print columnize(['a','b','c','d'], {displaywidth=>4});

produces:

    1  3
    2  4

With numeric data
-----------------

    $data_ref = [80..120];
    print columnize($data, {ljust = 0}) ;

produces:

    80  83  86  89  92  95   98  101  104  107  110  113  116  119
    81  84  87  90  93  96   99  102  105  108  111  114  117  120
    82  85  88  91  94  97  100  103  106  109  112  115  118

while:

   print columnize($data_ref, {ljust = 0, arrange_verticle = 0}) ;

produces:

   80  83  86  89  92  95   98  101  104  107  110  113  116  119
   81  84  87  90  93  96   99  102  105  108  111  114  117  120
   82  85  88  91  94  97  100  103  106  109  112  115  118

With String data
----------------

  $aref = qw(bibrons golden madascar leopard mourning suras tokay);
  print columnize $g, :displaywidth => 15
  $ print columnize($aref, {displaywidth => 15});
  bibrons   suras
  golden    tokay
  madascar  
  leapard
  mourning

  $ puts columnize $aref, {displaywidth => 18, colsep => ' | '};
  bibrons  | suras
  golden   | tokay
  madascar
  leopard 
  mourning

Credits
-------

  This is adapted from my Ruby gem of the same name.

Other stuff
-----------

Author:   Rocky Bernstein <rocky@cpan.org>
License:  Copyright (c) 2011 Rocky Bernstein

Warranty
--------

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
