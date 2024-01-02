#!/usr/bin/perl -w

#=============================================================================#
#=============================================================================#
use strict;


my %genes2matched;
open (FILE, "02.GOmatchedgenes") or die;
while (<FILE>) 
	{
	my $line = $_; chomp $line;
	$genes2matched{$line} = 1;
	}
close FILE;
####################################################

open (FILE1, $ARGV[0]) or die;
open (REPORT, ">03.HypergeometricTable\_$ARGV[0]\_$ARGV[1]\_report") or die;

my $totalsize = 18936;
my %hgdistribution;
my @query;
my @db;

while (<FILE1>) 
	{
	my $line = $_; chomp $line; $line = uc($line);
	my @element1 = split /\t/, $line;
	my $name1 = shift @element1;
	shift @element1;
	my $samplesize = 0; 
	for (my $i = 0; $i < scalar @element1; $i++) 
		{
		if (exists $genes2matched{$element1[$i]}) 
			{$samplesize++;}
		}
	if ($samplesize < 10) {next;}
	unless ($name1 ~~ @query)
			{push(@query, $name1);}
	open (FILE2, $ARGV[1]) or die;
	while (<FILE2>) 
		{
		my $line2 = $_; chomp $line2;$line2 = uc($line2);
		my @element2 = split /\t/, $line2;
		my $name2 = shift @element2;
		shift @element2;
		unless ($name2 ~~ @db)
			{push(@db, $name2);}

		my $totalpositivesize = 0;
		for (my $i = 0; $i < scalar @element2; $i++) 
			{
		 	if (exists $genes2matched{$element2[$i]}) 
		 		{$totalpositivesize ++;}
		 	}

		my $totalnegativesize = $totalsize - $totalpositivesize;

		my $samplepositivesize = 0;
		foreach my $elem1 (@element1)
			{if ($elem1 ~~ @element2) {$samplepositivesize++;}}

		my $rcommand = "R -e \'phyper \($samplepositivesize,$totalpositivesize,$totalnegativesize,$samplesize,lower.tail \= FALSE\)\'";
		my $rout = `$rcommand`;
		my @arr1 = split /\[1\] /, $rout;
		my @arr2 = split /\n/, $arr1[1];
		$hgdistribution{$name1}{$name2} = $arr2[0];
		print REPORT "$name1\t$name2\t$samplepositivesize,$totalpositivesize,$totalnegativesize,$samplesize\t$hgdistribution{$name1}{$name2}\n";
		}
	close FILE2;
	}
close REPORT;close FILE1;

open (OUT, ">03.HypergeometricTable\_$ARGV[0]\_$ARGV[1]\_noncorrectedP") or die;
open (OUT1, ">03.HypergeometricTable\_$ARGV[0]\_$ARGV[1]\_noncorrectedlogP") or die;
print OUT "GENESET";
print OUT1 "GENESET";
foreach my $name1(@db)
	{
	print OUT "\t$name1";
	print OUT1 "\t$name1";
	}
print OUT "\n";
print OUT1 "\n";
foreach my $name1(@query)
	{
	print OUT "$name1";
	print OUT1 "$name1";
	foreach my $name2(@db)
		{
		print OUT "\t$hgdistribution{$name1}{$name2}";
		my $temp = -log($hgdistribution{$name1}{$name2})/log(10);
		print OUT1 "\t$temp";
		}
	print OUT "\n";
	print OUT1 "\n";
	}
close OUT1;

