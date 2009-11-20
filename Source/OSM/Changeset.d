/*	NAME:
		Changeset.d

	DESCRIPTION:
		OSM changeset.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
import std.string;
import std.stdio;

import        RefNum.Files.BZip2;
public import RefNum.Core.Types;

public import OSM.Parser;





//============================================================================
//		Internal constants
//----------------------------------------------------------------------------
private const uint kBufferSize									= 3 * 1024 * 1024;





//============================================================================
//		Changeset.this : Constructor.
//----------------------------------------------------------------------------
class Changeset {

this(string thePath)
{


	// Initialise ourselves
	mFile = new BZip2(thePath);
}





//============================================================================
//		Changeset.processChanges : Process the changes.
//----------------------------------------------------------------------------
void processChanges(ElementHandler theHandler)
{	string		theBuffer;
	Parser		theParser;



	// Get the state we need
	theBuffer.length = kBufferSize;

	theParser               = new Parser;
	theParser.handleElement = theHandler;



	// Process the changeset
	if (mFile.open())
		{
		do
			{
			theBuffer.length = mFile.read(theBuffer); 
			theParser.parseBuffer(theBuffer);
			}
		while (theBuffer.length != 0);

		mFile.close();
		}
	
	
	delete theParser;
}





//============================================================================
//		Changeset : Private fields.
//----------------------------------------------------------------------------
private:
	BZip2								mFile;
}



