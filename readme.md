# mediainfo-d

D language bindings for libmediainfo

Prerequisites:
- You must have libmediainfo installed on your system
- A working D compiler and Dub.

Usage:
- Add 'mediainfo_d' as a dependancy to your dub project file.
- Please also read the dub documentation for details.

```
import mediainfodll;  /* Import the D binding module into scope */
import mediainfo;   /* Import optionally a more OO layer, WIP */
```

Todos:
- Added real unit- and module-tests
- Fixup OO layer for D2
