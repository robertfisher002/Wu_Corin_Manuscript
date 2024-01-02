#!/usr/bin/perl -w

#=============================================================================#
#=============================================================================#
use strict;
use POSIX;
use Parallel::ForkManager;
my $pm = new Parallel::ForkManager(40);

my @files = glob "*.cdt";

foreach my $file (@files)
	{
		my $pid = $pm->start and next; # Forks and returns the pid for the child:
	open(FILE, "$file") or die;
	my $newfilename = substr $file, 0, -4;
	open(OUT, ">$newfilename") or die;
	my $elemcnt = 0;
	while (<FILE>)
		{
		my $line = $_; chomp $line;
		my @element = split /\t/, $line;	
		if ($line =~ /^AID/ || $line =~ /^EWEIGHT/) 
			{next;}
		if ($line =~ /^Name/) 
			{$elemcnt = (scalar @element);}

		print OUT "$element[0]";
		for (my $i = 3; $i < $elemcnt; $i++) 
			{
			if (!exists $element[$i]) {print OUT "\tNA";}
			elsif ($element[$i] eq "") {print OUT "\tNA";}
			else {print OUT "\t$element[$i]";}
			}
		print OUT "\n";
		}
	close FILE;
		$pm->finish; # Terminates the child process
	}

$pm->wait_all_children();
