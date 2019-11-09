MapDiff
=======
MapDiff is a utility for visualising OpenStreetMap activity:

Each frame represents a daily diff, generated with Osmosis. Changes
are displayed as three colours - red for deletion, blue for creation,
and green for modification.



Usage
-----
MapDiff is invoked with a base map, an input change set, and a location to save the output:

```
    $ mapdiff --map=Map.png --input=2008_01_01.osc --output=2008_01_01.png
```

The base map must follow the "Google Tile" scheme, i.e., a square
mercator projection with a latitude extent of ±85.05112877980659.

The `Resources/` directory contains a sample map that fits this size, along
with scripts to automate the building of diff images and to convert them to a movie.



Building
--------
MapDiff is written in D, and can be built with GDC.



Version History
---------------
* mapdiff 1.0
  * Released 2008/03/06
  * Initial release
  
  