#Kaitlin Giles
#Read words from command line, count occurence of each word in text file
#Display word and count by frequency, then alphabetical order

#!/usr/bin/perl

$argcount = 1; #for tracking number of arguments passed into keys dictionary

foreach (@ARGV) { 
	if ($argcount < @ARGV) { #for all but last argument (which is input file)
		$keys{$_} = "0"; #save argument as key with value of 0
		$argcount++;
	}
}

$inputname = $ARGV[$argcount - 1]; # set input name to last argument in command line

open (my $fh, '<', $inputname) or die "Problem opening file. \n Usage: Giles_words.pl [search words separated by space] [input file name] \n"; # open input file
while (<$fh>){
	chomp;
	@words = split (' '); # seperate input file into words
	foreach my $word (@words){ #for each word in input file
		$word =~ s/[^a-zA-Z0-9]//g; #remove all but alphanumeric characters
		foreach my $key (%keys) { #for each word in key dictionary
			if (lc $word eq lc $key) { #if input file word matches key dictionary word, ignoring case	
				++$keys{$key}; #increment dictionary value assigned to key 
			}
		}
	}
}
close $fh;
			#sort descending by value, then alphabetically by key
foreach my $word (sort {$keys{$b} <=> $keys{$a} or $a cmp $b } keys %keys){
	printf "%-s: %s\n", $word, $keys{$word};
}

