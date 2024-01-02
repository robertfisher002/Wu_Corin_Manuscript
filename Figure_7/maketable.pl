#!/usr/bin/perl -w

#=============================================================================#
#=============================================================================#
use strict;

my %fileNref2match;
my %ref2symbol;

my @files = glob "*matchedcnt";

foreach my $file (@files)
	{
	open (FILE, $file) or die;
	while (<FILE>) 
		{
		my $line = $_; chomp $line;
		my @element = split /\t/, $line;
		my @arr = split /\|/, $element[3];
		if (!exists $ref2symbol{$arr[1]}) 
			{
			$ref2symbol{$arr[1]} = $arr[0];
			}
		$fileNref2match{$file}{$arr[1]} = "$element[-2]\t$element[-1]";
		}
	close FILE;
	}

open (FILE, "merged.exp") or die;
open (OUT, ">merged.exp.matchedcnt.report") or die;
while (<FILE>) 
	{
	my $line = $_; chomp $line;
	if ($line =~ /^transcript/) 
		{
		print OUT "$line\tsymbol";
		foreach my $file (@files)
			{print OUT "\t$file\.\.dmso\t$file\.\.corin";}
		print OUT "\n";
		}
	else
		{
		my @element = split /\t/, $line;
		my @arr = split /\_/, $element[0];my $ref = "$arr[0]\_$arr[1]";
		print OUT "$line\t$ref\|$ref2symbol{$ref}";
		foreach my $file (@files)
			{print OUT "\t$fileNref2match{$file}{$ref}";}
		print OUT "\n";
		}
	}

