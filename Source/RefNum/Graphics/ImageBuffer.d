/*	NAME:
		ImageBuffer.d

	DESCRIPTION:
		Image buffer.

	COPYRIGHT:
		Copyright (c) 2008, refNum Software
		<http://www.refnum.com/>

		All rights reserved. Released under the terms of licence.html.
	__________________________________________________________________________
*/
//============================================================================
//		Imports
//----------------------------------------------------------------------------
import std.file;

import lodepng.Decode;
import lodepng.Encode;

public import RefNum.Core.Geometry;
public import RefNum.Graphics.Colour;





//============================================================================
//		ImageBuffer.this : Constructor.
//----------------------------------------------------------------------------
class ImageBuffer {

static this()
{


	// Initialise ourselves
	buildBlend();
}





//============================================================================
//		ImageBuffer.this : Constructor.
//----------------------------------------------------------------------------
this(Size theSize)
{


	// Initialise ourselves
	mSize        = theSize;
	mData.length = rowBytes * cast(uint)(mSize.height);
}





//============================================================================
//		ImageBuffer.this : Constructor.
//----------------------------------------------------------------------------
this(string thePath)
{


	// Initialise ourselves
	read(thePath);
}





//============================================================================
//		ImageBuffer.size : Get the size.
//----------------------------------------------------------------------------
Size size()
{


	// Get the size
	return(mSize);
}





//============================================================================
//		ImageBuffer.rowBytes : Get the row bytes.
//----------------------------------------------------------------------------
UInt32 rowBytes()
{


	// Get the rowBytes
	return(cast(UInt32) (mSize.width * 4));
}





//============================================================================
//		ImageBuffer.blendPixel : Blend a pixel.
//----------------------------------------------------------------------------
void blendPixel(UInt32 x, UInt32 y, Colour thePixel)
{	UInt8		srcR, srcG, srcB, srcA;
	UInt8*		dstR, dstG, dstB;



	// Check our parameters
	if (x >= mSize.width || y >= mSize.height)
		return;



	// Get the state we need
	srcR = cast(UInt8) (thePixel.r * 255.0);
	srcG = cast(UInt8) (thePixel.g * 255.0);
	srcB = cast(UInt8) (thePixel.b * 255.0);
	srcA = cast(UInt8) (thePixel.a * 255.0);

	dstR = mData.ptr + (y * rowBytes) + (x * 4);
	dstG = dstR + 1;
	dstB = dstG + 1;



	// Blend the pixel
	*dstR = mBlendTable[srcA][srcR] + mBlendTable[255-srcA][*dstR];
	*dstG = mBlendTable[srcA][srcG] + mBlendTable[255-srcA][*dstG];
	*dstB = mBlendTable[srcA][srcB] + mBlendTable[255-srcA][*dstB];
}





//============================================================================
//		ImageBuffer.read : Read an image buffer from a file.
//----------------------------------------------------------------------------
void read(string thePath)
{	PngInfo		theInfo;



	// Read the image
	mData        = decode32(cast(ubyte[]) std.file.read(thePath), theInfo);
	mSize.width  = theInfo.image.width;
	mSize.height = theInfo.image.height;
}





//============================================================================
//		ImageBuffer.write : Write an image buffer to a file.
//----------------------------------------------------------------------------
void write(string thePath)
{	PngInfo		theInfo;
	UInt8[]		theData;



	// Write the image
	theInfo.image = PngImage(cast(UInt32) mSize.width, cast(UInt32) mSize.height, 8, ColorType.RGBA);
	theData       = encode(mData, theInfo);
	
	if (theData.length != 0)
		std.file.write(thePath, theData);
}





//============================================================================
//		ImageBuffer.buildBlend : Build the blend table.
//----------------------------------------------------------------------------
private:
static void buildBlend()
{	UInt32		a, c;
	Float32		f;



	// Build the blend table
	for (a = 0; a < 256; a++)
		{
		f = cast(Float32)(a) / 255.0f;

		for (c = 0; c < 256; c++)
			mBlendTable[a][c] = cast(UInt8)(f * c);
		}
}





//============================================================================
//		ImageBuffer : Private fields.
//----------------------------------------------------------------------------
private:
	Size								mSize;
	UInt8[]								mData;
	
	static UInt8[256][256]				mBlendTable;
}





