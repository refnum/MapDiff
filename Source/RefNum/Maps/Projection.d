/*	NAME:
		Projection.d

	DESCRIPTION:
		Projection object.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
public import RefNum.Core.Geometry;
public import RefNum.Maps.Coordinate;





//============================================================================
//		Constants
//----------------------------------------------------------------------------
enum ProjectionType {
	Mercator
};

const Degrees kMercatorLatitudeLimit								= 85.05112877980659;





//============================================================================
//		Projection.this : Constructor.
//----------------------------------------------------------------------------
class Projection {

this(ProjectionType theType)
{


	// Initialise ourselves
	mType = theType;
}





//============================================================================
//		Projection.type : Get the type.
//----------------------------------------------------------------------------
ProjectionType type()
{


	// Get the type
	return(mType);
}





//============================================================================
//		Projection.type : Set the type.
//----------------------------------------------------------------------------
ProjectionType type(ProjectionType theValue)
{


	// Set the type
	mType = theValue;

	return(mType);
}





//============================================================================
//		Projection.imageSize : Get the image size.
//----------------------------------------------------------------------------
Size imageSize()
{


	// Get the image size
	return(mImageSize);
}





//============================================================================
//		Projection.imageSize : Set the image size.
//----------------------------------------------------------------------------
Size imageSize(Size theValue)
{


	// Set the image size
	mImageSize = theValue;

	return(mImageSize);
}





//=============================================================================
//		Projection.project : Project a coordinate.
//-----------------------------------------------------------------------------
Point project(Coordinate thePosition)
{	Point	thePoint;



	// Project the coordinate
	switch (mType) {
		case ProjectionType.Mercator:
			thePoint = projectMercator(thePosition);
			break;
		
		default:
			assert(0, "Unknown projection");
			break;
		}
	
	return(thePoint);
}





//=============================================================================
//		Projection.unproject : Unproject a point.
//-----------------------------------------------------------------------------
Coordinate unproject(Point thePoint)
{	Coordinate	thePosition;



	// Unproject the point
	switch (mType) {
		case ProjectionType.Mercator:
			thePosition = unprojectMercator(thePoint);
			break;
		
		default:
			assert(0, "Unknown projection");
			break;
		}
	
	return(thePosition);
}





//=============================================================================
//		Projection.projectMercator : Mercator projection.
//-----------------------------------------------------------------------------
private:
Point projectMercator(Coordinate thePosition)
{	Radians		radLat, radLon;
	Point		thePoint;



	// Project the coordinate
	//
	// From http://mathworld.wolfram.com/MercatorProjection.html
	radLat = toRadians(thePosition.latitude);
	radLon = toRadians(thePosition.longitude);
	
	thePoint.x = radLon;
	thePoint.y = asinh(tan(radLat));



	// Convert to image coordinates
	//
	// As well as raw projection, we can also project to a specific image size.
	if (mImageSize.width != 0.0)
		{
		// Translate the origin
		//
		// Projected coordinates put the origin at the centre, with +Y running upwards.
		//
		// Image coordinates put the origin at the top left, with +Y running downwards.
		prepareImage();

		thePoint.x = thePoint.x    - mMercatorMinX;
		thePoint.y = mMercatorMaxY - thePoint.y;



		// Adjust the scale
		thePoint.x *= mMercatorInvSize.width  * mImageSize.width;
		thePoint.y *= mMercatorInvSize.height * mImageSize.height;
		}
	
	return(thePoint);
}





//=============================================================================
//		Projection.unprojectMercator : Mercator unprojection.
//-----------------------------------------------------------------------------
Coordinate unprojectMercator(Point thePoint)
{	Radians			radLat, radLon;
	Coordinate		thePosition;
	Point			mercPoint;



	// Validate our state
	assert(mImageSize.width != 0.0);



	// Undo the scale
	prepareImage();

	mercPoint.x = (thePoint.x / mImageSize.width)  * mMercatorSize.width;
	mercPoint.y = (thePoint.y / mImageSize.height) * mMercatorSize.height;



	// Restore the origin
	mercPoint.x = mMercatorMinX + mercPoint.x;
	mercPoint.y = mMercatorMaxY - mercPoint.y;



	// Unproject the position
	//
	// From http://mathworld.wolfram.com/MercatorProjection.html
	radLon = mercPoint.x;
	radLat = atan(sinh(mercPoint.y));

	thePosition.latitude  = toDegrees(radLat);
	thePosition.longitude = toDegrees(radLon);

	return(thePosition);
}





//=============================================================================
//		Projection.prepareImage : Prepare for image conversion.
//-----------------------------------------------------------------------------
void prepareImage()
{


	// Check our state
	if (mMercatorMinX != 0.0)
		return;



	// Update our state
	//
	// The mercator projection can process coordinates ranging from +180/-180
	// degrees in longitude, and around +84/-84 degrees in latitude.
	//
	// When projecting to/from the image size coordinate system, we need these
	// limits in radians.
	mMercatorMinX = -PI;
	mMercatorMaxY = asinh(tan(toRadians(kMercatorLatitudeLimit)));

	mMercatorSize.width  = 2.0 * PI;
	mMercatorSize.height = 2.0 * mMercatorMaxY;
	
	mMercatorInvSize.width  = 1.0 / mMercatorSize.width;
	mMercatorInvSize.height = 1.0 / mMercatorSize.height;
}





//============================================================================
//		Projection : Private fields.
//----------------------------------------------------------------------------
private:
	ProjectionType						mType;
	Size								mImageSize;

	Radians								mMercatorMinX    = 0.0;
	Radians								mMercatorMaxY    = 0.0;
	Size								mMercatorSize;
	Size								mMercatorInvSize;
}

