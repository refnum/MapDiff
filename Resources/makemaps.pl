#!/usr/bin/perl -w
#============================================================================
#	NAME:
#		makemaps.pl
#
#	DESCRIPTION:
#		Generate map images from diff files.
#	
#	COPYRIGHT:
#		Copyright (c) 2008, refNum Software
#		<http://www.refnum.com/>
#
#		All rights reserved. Released under the terms of licence.html.
#============================================================================
#		Module header
#----------------------------------------------------------------------------
use strict;





#============================================================================
#		Constants
#----------------------------------------------------------------------------
my $kPathBaseMap  = "/usr/local/develop/MapDiff/Resources/Map.png";
my $kPathMapDiff  = "/usr/local/develop/MapDiff/Project/mapdiff";
my $kPathInput    = "/usr/local/develop/OpenStreetMap/Data/Daily";
my $kPathOutput   = "/usr/local/develop/OpenStreetMap/Data/Daily/Maps";
my $kPathFont     = "/usr/share/fonts/truetype/ttf-dejavu/DejaVuSans.ttf";





#============================================================================
#		makeDiff : Create a diff.
#----------------------------------------------------------------------------
sub makeDiff
{


	# Retrieve our parameters
	my ($pathChange) = @_;



	# Get the state we need
	my $pathImage = $pathChange;
	$pathImage    =~ s/(.*)\/(.*).osc.*/$1\/Maps\/$2.png/;



	# Create the diff
	system($kPathMapDiff, "--map=$kPathBaseMap", "--input=$pathChange", "--output=$pathImage") == 0 or die;

	if ($pathImage =~ /daily-(\d\d\d\d)(\d\d)(\d\d)/)
		{
		my $theDate = "\"$1_$2_$3\"";
		`convert -fill white -pointsize 20 -draw 'text 20,50 $theDate' -font $kPathFont $pathImage $pathImage`;
		}
}





#============================================================================
#		makeDiffs : Create the diffs.
#----------------------------------------------------------------------------
sub makeDiffs
{


	# Get the state we need
	my @theFiles = sort glob("$kPathInput/*.osc*");
	
	`mkdir -p "$kPathOutput"`;



	# Create the diffs
	foreach my $theFile (@theFiles)
		{
		makeDiff($theFile);
		}
}





#============================================================================
#		main : Script entry point.
#----------------------------------------------------------------------------
makeDiffs();
	
					
