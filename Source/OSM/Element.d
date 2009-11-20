/*	NAME:
		Element.d

	DESCRIPTION:
		XML element.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
import std.regexp;
import std.string;

public import RefNum.Core.Types;





//============================================================================
//		Element.this : Constructor.
//----------------------------------------------------------------------------
class Element {

static this()
{


	// Initialise ourselves
	mRegExpName      = new RegExp("</?(!--|\\w+)");
	mRegExpAttribute = new RegExp("=\"(.*?)\"");
}





//============================================================================
//		Element.this : Constructor.
//----------------------------------------------------------------------------
this(string theToken)
{


	// Validate our parameters
	assert(theToken.length >= 2);



	// Initialise ourselves
	mToken = theToken;
}





//============================================================================
//		Element.value : Get the value.
//----------------------------------------------------------------------------
string value()
{


	// Get the value
	return(mToken);
}





//============================================================================
//		Element.isOpenTag : Is this an open tag?
//----------------------------------------------------------------------------
bool isOpenTag()
{


	// Is this an open tag?
	return(mToken[1] != '/');
}





//============================================================================
//		Element.isEndTag : Is this an end tag?
//----------------------------------------------------------------------------
bool isEndTag()
{


	// Is this an end tag?
	return(mToken[1] == '/');
}





//============================================================================
//		Element.name : Get the name.
//----------------------------------------------------------------------------
string name()
{	string		theValue;
	string[]	matches;



	// Get the name
	matches = mRegExpName.match(mToken);

	if (matches.length == 2)
		theValue = matches[1];
	
	return(theValue);
}





//============================================================================
//		Element.getAttribute : Get an attribute.
//----------------------------------------------------------------------------
string getAttribute(string theKey)
{	string		theValue;
	string[]	matches;
	SInt32		offset;



	// Get the attribute
	offset = std.string.find(mToken, theKey);
	if (offset != -1)
		{
		offset += theKey.length;
		matches = mRegExpAttribute.match(mToken[offset..$]);

		if (matches.length == 2)
			theValue = matches[1];
		}
	
	return(theValue);
}





//============================================================================
//		Element.getAttributeInt : Get an integer attribute.
//----------------------------------------------------------------------------
SInt64 getAttributeInt(string theKey)
{


	// Get the attribute
	return(atoi(getAttribute(theKey)));
}





//============================================================================
//		Element.getAttributeFloat : Get a float attribute.
//----------------------------------------------------------------------------
Float64 getAttributeFloat(string theKey)
{


	// Get the attribute
	return(atof(getAttribute(theKey)));
}





//============================================================================
//		Element : Private fields.
//----------------------------------------------------------------------------
private:
	string								mToken;
	
	static RegExp						mRegExpName;
	static RegExp						mRegExpAttribute;
}


