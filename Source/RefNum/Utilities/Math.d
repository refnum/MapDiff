/*	NAME:
		Math.d

	DESCRIPTION:
		Math utilities.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
public import std.math;

public import RefNum.Core.Types;





//============================================================================
//		Types
//----------------------------------------------------------------------------
alias Float64 Degrees;
alias Float64 Radians;





//=============================================================================
//		Math.toRadians : Convert degrees to radians.
//-----------------------------------------------------------------------------
Radians toRadians(Degrees theValue)
{
    return(theValue * (PI / 180.0));
}





//=============================================================================
//		Math.toDegrees : Convert radians to degrees.
//-----------------------------------------------------------------------------
Degrees toDegrees(Radians theValue)
{
    return(theValue * (180.0 / PI));
}


