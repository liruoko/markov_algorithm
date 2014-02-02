#!/usr/bin/perl

=head1 

> cat alg1
*. -> ..*
* =>
. -> *.

> ./m-alg.pl ..... <alg1
source: .....
1 *.....
2 ..*....
3 ....*...
4 ......*..
5 ........*.
6 ..........*
result: ..........

=cut

use strict;
use warnings;

my $text = $ARGV[0];
my @prog_text = <STDIN>;
my @rules;
for my $str (@prog_text){
    $str =~ /^\s*([^\s]*)\s+([\-=])>\s+([^\s]*)\s*$/;
    push @rules, {source => $1 // '', subst => $3 // '', stop => $2 eq '='};
}

print "source: ".$text."\n";
my $i = 0;
PROG: while (1){
    last if $i++ > 100;
    for my $r (@rules){
        my $applied = ($text =~ s/\Q$r->{source}\E/$r->{subst}/);
        last PROG if $applied && $r->{stop};
        next PROG if $applied;
    }
    last;
}
continue{
    print "$i ".$text."\n";
}
print "result: ".$text."\n";
