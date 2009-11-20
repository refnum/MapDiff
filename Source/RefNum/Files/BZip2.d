/*	NAME:
		BZip2.d

	DESCRIPTION:
		BZip2 object.

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

public import RefNum.Core.Types;





//============================================================================
//		Glue
//----------------------------------------------------------------------------
typedef void *BZFILE;

extern (C) BZFILE *BZ2_bzopen (char *path, char *mode);
extern (C) int     BZ2_bzread (BZFILE* b, void* buf, int len);
extern (C) void    BZ2_bzclose(BZFILE* b);





//============================================================================
//		BZip2.this : Constructor.
//----------------------------------------------------------------------------
class BZip2 {

this(string thePath)
{


	// Initialise ourselves
	mPath = thePath;
	mFile = null;
}





//============================================================================
//		BZip2.~this : Destructor.
//----------------------------------------------------------------------------
~this()
{


	// Clean up
	close();
}





//============================================================================
//		BZip2.open : Open the file.
//----------------------------------------------------------------------------
bool open()
{


	// Open the file
	mFile = BZ2_bzopen(mPath.ptr, "r");
	return(mFile != null);
}





//============================================================================
//		BZip2.close : Close the file.
//----------------------------------------------------------------------------
void close()
{


	// Close the file
	if (mFile != null)
		{
		BZ2_bzclose(mFile);
		mFile = null;
		}
}





//============================================================================
//		BZip2.read : Read data from the file.
//----------------------------------------------------------------------------
UInt32 read(string theBuffer)
{	UInt32		numRead;


	// Read the data
	numRead = BZ2_bzread(mFile, theBuffer.ptr, theBuffer.length);
	return(numRead);
}





//============================================================================
//		BZip2 : Private fields.
//----------------------------------------------------------------------------
private:
	string								mPath;
	BZFILE								*mFile;
}





