#!/bin/sh
#============================================================================
#	NAME:
#		makevideo.sh
#
#	DESCRIPTION:
#		Generate a video from a .png sequence. MPlayer docs are at:
#
#			http://www.mplayerhq.hu/DOCS/man/en/mplayer.1.html
#
#		flvtool2 is optional, but allows seeking within the movie.
#	
#	COPYRIGHT:
#		Copyright (c) 2008, refNum Software
#		<http://www.refnum.com/>
#
#		All rights reserved. Released under the terms of licence.html.
#============================================================================
#		Constants
#----------------------------------------------------------------------------
PATH_INPUT=/usr/local/develop/OpenStreetMap/Data/Daily/Maps/*.png
PATH_OUTPUT=/usr/local/develop/OpenStreetMap/Data/Daily/Maps/mapdiff.flv





#============================================================================
#		Script
#----------------------------------------------------------------------------
mencoder mf://$PATH_INPUT -vf crop=1024:768:0:10 -mf fps=5:type=png 			\
			-o $PATH_OUTPUT -ofps 30 -of lavf -ovc lavc 						\
			-lavfopts i_certify_that_my_video_stream_does_not_use_b_frames		\
			-lavcopts vcodec=flv:keyint=50:vbitrate=1800:mbd=2:mv0:trell:v4mv:cbp:last_pred=3 

flvtool2 -U $PATH_OUTPUT 

