/*	NAME:
		Geometry.d

	DESCRIPTION:
		Geometry utilities.

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
//		Types
//----------------------------------------------------------------------------
struct Point {
	Float32		x			= 0.0;
	Float32		y			= 0.0;
};

struct Size {
	Float32		width		= 0.0;
	Float32		height		= 0.0;
};

struct Rect {
	Point		origin;
	Size		size;
};

