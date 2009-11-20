/*	NAME:
		Parser.d

	DESCRIPTION:
		Shallow stream-based XML parser.

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
import std.regexp;
import std.stdio;

public import OSM.Element;





//============================================================================
//		Types
//----------------------------------------------------------------------------
typedef void delegate(Element theElement) ElementHandler;





//============================================================================
//		Parser.this : Constructor.
//----------------------------------------------------------------------------
class Parser {

static this()
{


	// Initialise ourselves
	mRegExpToken = new RegExp("(<.*?>)", "m");
}





//============================================================================
//		Parser.this : Constructor.
//----------------------------------------------------------------------------
this()
{


	// Initialise ourselves
	mHandlerElement = &ignoreElement;
}





//============================================================================
//		Parser.handleElement : Get the element handler.
//----------------------------------------------------------------------------
ElementHandler handleElement()
{


	// Get the handler
	return(mHandlerElement);
}





//============================================================================
//		Parser.handleElement : Set the element handler.
//----------------------------------------------------------------------------
ElementHandler handleElement(ElementHandler theHandler)
{


	// Set the handler
	mHandlerElement = theHandler;
	
	return(mHandlerElement);
}





//============================================================================
//		Parser.parseBuffer : Continue parsing a buffer.
//----------------------------------------------------------------------------
void parseBuffer(string theBuffer)
{	Element		theElement;
	string		theToken;



	// Get the state we need
	mData ~= theBuffer;



	// Parse the stream
	while (parseToken(theToken))
		{
		theElement = new Element(theToken);
		mHandlerElement(theElement);
		delete theElement;
		}



	// Update our state
	if (mOffset >= mData.length)
		mData = "";
	else
		mData = mData[mOffset..$];

	mOffset = 0;



	// Clean up
	if (theBuffer.length == 0)
		{
		mData   = "";
		mOffset = 0;
		}
}





//============================================================================
//		Parser.ignoreElement : Default element handler.
//----------------------------------------------------------------------------
private:
void ignoreElement(Element theElement)
{
}





//============================================================================
//		Parser.parseToken : Parse the next token.
//----------------------------------------------------------------------------
bool parseToken(inout string theToken)
{	UInt32		start, end;
	string[]	matches;



	// Check our state
	if (mOffset >= mData.length)
		return(false);



	// Get the token
	//
	// RegExp will return matches past the end of the array, and so
	// we need to check for and reject bogus results.
	theToken.length = 0;
	matches         = mRegExpToken.match(mData[mOffset..$]);

	if (matches.length == 2)
		{
		start = mOffset + mRegExpToken.pre().length;
		end   = start   + matches[1].length;

		if (end <= mData.length)
			{
			theToken = mData[start..end];
			mOffset  = end + 1;
			}
		}

	return(theToken.length != 0);
}





//============================================================================
//		Parser : Private fields.
//----------------------------------------------------------------------------
private:
	string								mData;
	UInt32								mOffset;
	ElementHandler						mHandlerElement;

	static RegExp						mRegExpToken;
}



