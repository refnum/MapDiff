/*	NAME:
		MapDiff.d

	DESCRIPTION:
		Generates visual diffs for OSM.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
import std.stdio;
import std.string;
import std.regexp;
import std.c.time;

import RefNum.Graphics.ImageBuffer;
import RefNum.Maps.Projection;

import OSM.Changeset;





//============================================================================
//		MapDiff.this : Constructor.
//----------------------------------------------------------------------------
class MapDiff {

this(string pathMap, string pathOutput, string pathDiff)
{


	// Initialise ourselves
	mPathMap    = pathMap;
	mPathOutput = pathOutput;
	mPathDiff   = pathDiff;

	mMapProjection = new Projection(ProjectionType.Mercator);

	mColourCreate  = new Colour(0.0f, 1.0f, 0.0f, 0.5f);
	mColourDelete  = new Colour(1.0f, 0.0f, 0.0f, 0.5f);
	mColourModify  = new Colour(0.0f, 0.0f, 1.0f, 0.5f);
	mColourCurrent = mColourCreate;
}





//============================================================================
//		recordChange : Record a change.
//----------------------------------------------------------------------------
void recordChange(Element theChange)
{	Coordinate		thePosition;
	Point			thePoint;
	string			theName;



	// Get the state we need
	if (theChange.isEndTag())
		return;

	theName = theChange.name();



	// Process a change
	if (theName == "create")
		mColourCurrent = mColourCreate;

	else if (theName == "delete")
		mColourCurrent = mColourDelete;

	else if (theName == "modify")
		mColourCurrent = mColourModify;



	// Process a node
	else if (theName == "node")
		{
		// Update the image
		thePosition = new Coordinate(theChange.getAttributeFloat("lat"), theChange.getAttributeFloat("lon"));
		thePoint    = mMapProjection.project(thePosition);

		mMapImage.blendPixel(cast(uint) thePoint.x, cast(uint) thePoint.y, mColourCurrent);
		delete thePosition;



		// Dump some progress
		mChangeCount++;

		if ((mChangeCount % 500000) == 0)
			mMapImage.write(mPathOutput);
		}
}





//============================================================================
//		drawAxes : Draw some axes on the image.
//----------------------------------------------------------------------------
void drawAxes()
{	Coordinate		thePosition;
	Point			thePoint;



	// Get the state we need
	thePosition = new Coordinate(0.0, 0.0);



	// Plot the axes
	for (float x = -180.0; x < 180.0; x++)
		{
		thePosition.longitude = x;
		thePosition.latitude  = 0.0;
		thePoint              = mMapProjection.project(thePosition);
		mMapImage.blendPixel(cast(uint) thePoint.x, cast(uint) thePoint.y, mColourCreate);
		}

	for (float y = -90.0; y < 90.0; y++)
		{
		thePosition.longitude = 0.0;
		thePosition.latitude  = y;
		thePoint  = mMapProjection.project(thePosition);
		mMapImage.blendPixel(cast(uint) thePoint.x, cast(uint) thePoint.y, mColourDelete);
		}
	
	
	
	// Clean up
	delete thePosition;
}





//============================================================================
//		generateDiff : Generate the map diff.
//----------------------------------------------------------------------------
void generateDiff()
{	Changeset	osmDiff;



	// Print some progress
	writefln("Processing %s into %s", baseName(mPathDiff), baseName(mPathOutput));



	// Load the image
	mMapImage                = new ImageBuffer(mPathMap);
	mMapProjection.imageSize = mMapImage.size();



	// Generate the diff
	osmDiff = new Changeset(mPathDiff);
	osmDiff.processChanges(&recordChange);



	// Save the image
	mMapImage.write(mPathOutput);
}





//============================================================================
//		baseName : Get the base name for a file.
//----------------------------------------------------------------------------
//		Note : Should use std.path.basename, missing on Mac OS X?
//----------------------------------------------------------------------------
private:
string baseName(string thePath)
{


	// Get the base name
	return(sub(thePath, ".*/", "", "g"));
}





//============================================================================
//		MapDiff : Private fields.
//----------------------------------------------------------------------------
private:
	string								mPathMap;
	string								mPathOutput;
	string								mPathDiff;

	ImageBuffer							mMapImage;
	Projection							mMapProjection;
	UInt32								mChangeCount;
	
	Colour								mColourCreate;
	Colour								mColourDelete;
	Colour								mColourModify;
	Colour								mColourCurrent;
}





//============================================================================
//		main : Program entry point.
//----------------------------------------------------------------------------
int main(string[] args)
{	string				pathMap, pathOutput, pathDiff;
	MapDiff				mapDiff;
	string[]			matches;
	RegExp				argEx;



	// Get the state we need
	//
	// Should use getopt, missing on Mac OS X?
	argEx = new RegExp("--(.*)=(.*)");

	foreach (theArg; args)
		{
		matches = argEx.match(theArg);
		if (matches.length == 3)
			{
			if (matches[1] == "map")		pathMap    = matches[2];
			if (matches[1] == "output")		pathOutput = matches[2];
			if (matches[1] == "input")		pathDiff   = matches[2];
			}
		}



	// Print some help
	if (pathMap == "" || pathOutput == "" || pathDiff == "")
		{
		writefln("mapdiff --map=map.png --input=diff.osc --output=diff.png");
		writefln("    Generates a diff map, given a base map and an Osmosis change set");
		return(-1);
		}



	// Generate the diff
	mapDiff = new MapDiff(pathMap, pathOutput, pathDiff);
	mapDiff.generateDiff();
	
	return(0);
}



