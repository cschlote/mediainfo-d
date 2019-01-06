
# mediainfo-d

D language bindings for libmediainfo

Prerequisites:
- You must have libmediainfo installed on your system
- A working D compiler and Dub.

Usage:
- Add 'mediainfo-d' as a dependancy to your dub project file.
- Please also read the dub documentation for details.

```
import mediainfodll;  /* Import the D binding module into scope */
import mediainfo;   /* Import optionally a more OO layer, WIP */
```

Todos:
- Added real unit- and module-tests
- Port the higher level C++ classes to D
- Cleanups

Annotation:
While working on the dub package, I found some older work at https://github.com/jpf91/MediaInfoD .
I adapted and ported some of the code and the example to D2 and latest libphobos for the dub packaging.
