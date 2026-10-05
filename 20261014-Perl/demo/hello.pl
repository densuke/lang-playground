use strict;
use warnings;

print "Hello, world!\n";

# 変数の頭の記号で型が分かる: $ はスカラー、@ は配列、% はハッシュ
my $name  = "Perl";
my @langs = ("C", "sed", "awk", "sh");
my %born  = (Perl => 1987, Perl5 => 1994);

print "$name は @langs のいいとこ取り\n";
print "Perl 1.0 は $born{Perl} 年、Perl 5 は $born{Perl5} 年\n";
