#!/usr/bin/perl
# ラムダ式 -> BLC のビット列。使い方: perl lam2blc.pl [-s] [-B] [-d] [ファイル]  (ファイルなしなら標準入力)
#   -s  ビットを 00 / 01 / 1..10 の区切りつきで出す (人が読む用)
#   -B  8 ビットずつ詰めたバイト列で出す (末尾は 0 で埋める。tromp の既定のバイトモード用)
#   -d  変数名のかわりに de Bruijn 添字 (数字 1 桁) で書く。例: \\\132
# 書式: \x y.本体 / 適用は並べるだけ(左結合) / "Hi" は 8 ビットのリストへ展開 / -- 以降は行コメント
use strict; use warnings;
my %opt = map { $_ => 1 } grep { /^-[sBd]$/ } @ARGV;
@ARGV = grep { !/^-[sBd]$/ } @ARGV;
my $src = join '', <>;
$src =~ s/--[^\n]*//g;
$src =~ s/\xCE\xBB/\\/g;   # UTF-8 の λ

# "Hi" -> ビット(True=0, False=1)の組(\z.z x rest)で作ったリスト。終端は Nil = False
sub bit  { $_[0] ? '(\a b.b)' : '(\a b.a)' }
sub cons { "(\\z.z $_[0] $_[1])" }
sub str {
    my $list = '(\a b.b)';
    for my $byte (reverse unpack 'C*', $_[0]) {
        my $bits = '(\a b.b)';
        $bits = cons(bit(($byte >> $_) & 1), $bits) for 0 .. 7;
        $list = cons($bits, $list);
    }
    $list;
}
$src =~ s/"([^"]*)"/str($1)/ge;

my @tok = $src =~ /\\|\.|\(|\)|[A-Za-z_][A-Za-z_0-9']*|\d/g;
my $pos = 0;

sub parse_term {    # 適用の列。'.' や ')' で終わる
    my ($env) = @_;
    my @items;
    while ($pos < @tok && $tok[$pos] ne ')') {
        my $t = $tok[$pos++];
        if ($t eq '(') { push @items, parse_term($env); $pos++ }
        elsif ($t eq '\\') {
            my @names;
            if ($opt{-d}) { push @names, '_' }
            else { push @names, $tok[$pos++] while $tok[$pos] ne '.' ; $pos++ }
            push @items, lambda(\@names, $env);
        }
        elsif ($t =~ /^\d$/ && $opt{-d}) { push @items, ['V', $t] }
        else {
            my ($i) = grep { $env->[$_] eq $t } 0 .. $#$env;
            die "未束縛の変数: $t\n" unless defined $i;
            push @items, ['V', $i + 1];
        }
    }
    die "空の式\n" unless @items;
    my $f = shift @items;
    $f = ['A', $f, $_] for @items;
    $f;
}
sub lambda {    # 名前を順に束ね、本体は右へ最大限のばす
    my ($names, $env) = @_;
    my ($n, @rest) = @$names;
    my @e = ($n, @$env);                       # 先頭が最も内側 = 添字 1
    return ['L', @rest ? lambda(\@rest, \@e) : parse_term(\@e)];
}
sub enc {
    my ($t) = @_;
    return ('00', enc($t->[1])) if $t->[0] eq 'L';
    return ('01', enc($t->[1]), enc($t->[2])) if $t->[0] eq 'A';
    return ('1' x $t->[1] . '0');
}
my @chunks = enc(parse_term([]));
die "余った入力\n" if $pos < @tok;
if ($opt{-B}) { print pack 'B*', join '', @chunks }
elsif ($opt{-s}) { print join(' ', @chunks), "\n" }
else { print join '', @chunks }
