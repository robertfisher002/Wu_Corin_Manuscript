#!/usr/bin/env perl


my @control1 = (1,2); ## array component
my @test1 = (3,4,5,6,7,8);
my @control2 = (9,10); ## array component
my @test2 = (11,12,13,14,15,16);

my @files = glob "*.both.table";

#############################
sub average {
        my (@values) = @_;
        my $count = scalar @values;
        my $total = 0; 
        $total += $_ for @values; 
        return $count ? $total / $count : 0;
}

sub stdev {
        my ($average, @values) = @_;
        my $count = scalar @values;
        my $std_dev_sum = 0;
        $std_dev_sum += ($_ - $average) ** 2 for @values;
        return $count ? sqrt($std_dev_sum / $count) : 0;
}
#############################

foreach my $file (@files)
	{
	open(FILE, $file);
	open(AVGCENTEREDSD, ">$file.eachcellavgcenteredSD");

	while (<FILE>) 
		{
		my $line = $_; chomp $line;
		if ($line =~ /^Name/) 
			{
			print AVGCENTEREDSD "$line\n";
			next;
			}
		my @element = split /\t/, $line;

		my $controlavg1 = ($element[1]+$element[2])/2;
		my $controlavg2 = ($element[9]+$element[10])/2;

		my @arr1 = (); for (my $i = 1; $i < 9; $i++) {push (@arr1, $element[$i]);}
		my $totalsd1 = stdev (@arr1); if ($totalsd1 == 0) {next;}
		my @arr2 = (); for (my $i = 9; $i < 17; $i++) {push (@arr2, $element[$i]);}
		my $totalsd2 = stdev (@arr2); if ($totalsd2 == 0) {next;}

###########
		print AVGCENTEREDSD "$element[0]";
		for (my $i = 1; $i < 9; $i++) 
			{
			my $avgcenteredsd = ($element[$i] - $controlavg1) / $totalsd1;
			print AVGCENTEREDSD "\t$avgcenteredsd";
			}
		for (my $i = 9; $i < 17; $i++) 
			{
			my $avgcenteredsd = ($element[$i] - $controlavg2) / $totalsd2;
			print AVGCENTEREDSD "\t$avgcenteredsd";
			}
		print AVGCENTEREDSD "\n";

###########
		}
	}






