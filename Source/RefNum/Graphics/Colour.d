/*	NAME:
		Colour.d

	DESCRIPTION:
		Colour object.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
public import RefNum.Core.Types;





//============================================================================
//		Colour.this : Constructor.
//----------------------------------------------------------------------------
class Colour {

this(Float32 r, Float32 g, Float32 b, Float32 a)
{


	// Initialise ourselves
	mRed   = r;
	mGreen = g;
	mBlue  = b;
	mAlpha = a;
}





//============================================================================
//		Colour.this : Constructor.
//----------------------------------------------------------------------------
this(Float32 r, Float32 g, Float32 b)
{


	// Initialise ourselves
	mRed   = r;
	mGreen = g;
	mBlue  = b;
	mAlpha = 1.0f;
}





//============================================================================
//		Colour.r : Get the red component.
//----------------------------------------------------------------------------
Float32 r()
{


	// Get the component
	return(mRed);
}





//============================================================================
//		Colour.r : Set the red component.
//----------------------------------------------------------------------------
Float32 r(Float32 theValue)
in
{
	assert(theValue >= 0.0 && theValue <= 1.0);
}
body
{


	// Set the component
	mRed = theValue;
	
	return(mRed);
}





//============================================================================
//		Colour.g : Get the green component.
//----------------------------------------------------------------------------
Float32 g()
{


	// Get the component
	return(mGreen);
}





//============================================================================
//		Colour.g : Set the green component.
//----------------------------------------------------------------------------
Float32 g(Float32 theValue)
in
{
	assert(theValue >= 0.0 && theValue <= 1.0);
}
body
{


	// Set the component
	mGreen = theValue;
	
	return(mGreen);
}





//============================================================================
//		Colour.b : Get the blue component.
//----------------------------------------------------------------------------
Float32 b()
{


	// Get the component
	return(mBlue);
}





//============================================================================
//		Colour.b : Set the blue component.
//----------------------------------------------------------------------------
Float32 b(Float32 theValue)
in
{
	assert(theValue >= 0.0 && theValue <= 1.0);
}
body
{


	// Set the component
	mBlue = theValue;
	
	return(mBlue);
}





//============================================================================
//		Colour.a : Get the alpha component.
//----------------------------------------------------------------------------
Float32 a()
{


	// Get the component
	return(mAlpha);
}





//============================================================================
//		Colour.a : Set the alpha component.
//----------------------------------------------------------------------------
Float32 a(Float32 theValue)
in
{
	assert(theValue >= 0.0 && theValue <= 1.0);
}
body
{


	// Set the component
	mAlpha = theValue;
	
	return(mAlpha);
}





//============================================================================
//		Colour : Unit tests.
//----------------------------------------------------------------------------
unittest
{	Colour		testObject = new Colour;


	delete testObject;
}





//============================================================================
//		Colour : Private fields.
//----------------------------------------------------------------------------
private:
	Float32								mRed;
	Float32								mGreen;
	Float32								mBlue;
	Float32								mAlpha;
}



