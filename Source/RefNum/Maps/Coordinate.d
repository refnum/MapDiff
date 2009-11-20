/*	NAME:
		Coordinate.d

	DESCRIPTION:
		Coordinate object.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
public import RefNum.Utilities.Math;





//============================================================================
//		Coordinate.this : Constructor.
//----------------------------------------------------------------------------
class Coordinate {

this(Degrees latitude, Degrees longitude)
{


	// Initialise ourselves
	mLatitude  = latitude;
	mLongitude = longitude;
}





//============================================================================
//		Coordinate.latitude : Get the latitude.
//----------------------------------------------------------------------------
Degrees latitude()
{


	// Get the latitude
	return(mLatitude);
}





//============================================================================
//		Coordinate.latitude : Set the latitude.
//----------------------------------------------------------------------------
Degrees latitude(Degrees theValue)
{


	// Set the latitude
	mLatitude = theValue;

	return(mLatitude);
}





//============================================================================
//		Coordinate.longitude : Get the longitude.
//----------------------------------------------------------------------------
Degrees longitude()
{


	// Get the longitude
	return(mLongitude);
}





//============================================================================
//		Coordinate.longitude : St the longitude.
//----------------------------------------------------------------------------
Degrees longitude(Degrees theValue)
{


	// Set the longitude
	mLongitude = theValue;

	return(mLongitude);
}





//============================================================================
//		Coordinate.opEquals : Equality operator.
//----------------------------------------------------------------------------
int opEquals(Object other)
{	Coordinate	otherObject = cast(Coordinate) other;



	// Compare the objects
	return(	mLatitude  == otherObject.mLatitude &&
			mLongitude == otherObject.mLongitude);
}





//============================================================================
//		Coordinate : Private fields.
//----------------------------------------------------------------------------
private:
	Degrees								mLatitude;
	Degrees								mLongitude;
}







