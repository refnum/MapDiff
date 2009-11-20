#============================================================================
#	Locations
#----------------------------------------------------------------------------
OBJECTS		:=	Build
INCLUDES	:=	../Source												\
				../Source/External										\
				../Source/OSM											\
				../Source/RefNum

SOURCES		:=	../Source/MapDiff.d										\
				../Source/External/lodepng/Common.d						\
				../Source/External/lodepng/Decode.d						\
				../Source/External/lodepng/Encode.d						\
				../Source/External/lodepng/util.d						\
				../Source/External/lodepng/ZlibCodec.d					\
				../Source/OSM/Changeset.d								\
				../Source/OSM/Element.d									\
				../Source/OSM/Parser.d									\
				../Source/RefNum/Core/Geometry.d						\
				../Source/RefNum/Core/Types.d							\
				../Source/RefNum/Files/BZip2.d							\
				../Source/RefNum/Graphics/Colour.d						\
				../Source/RefNum/Graphics/ImageBuffer.d					\
				../Source/RefNum/Maps/Coordinate.d						\
				../Source/RefNum/Maps/Projection.d						\
				../Source/RefNum/Utilities/Math.d





#============================================================================
#	Options
#----------------------------------------------------------------------------
DC			:=	gdmd
DFLAGS		:=	-O -c

LIBLIST		:=	-L-lbz2
INCLIST		:=	$(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir))

OBJECTLIST	:=	$(subst ../Source/,Build/,$(SOURCES:.d=.o))





#============================================================================
#	Rules
#----------------------------------------------------------------------------
all: mapdiff


clean:
	rm -fr mapdiff $(OBJECTS)


$(OBJECTS)/%.o : ../Source/%.d
	$(DC) $(DFLAGS) -od$(@D) $(INCLIST) $<


mapdiff : $(OBJECTLIST)
	$(DC) -ofmapdiff $(OBJECTLIST) $(LIBLIST)




