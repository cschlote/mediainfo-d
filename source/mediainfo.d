/**
 * Object oriented wrapper for $(LINK2 http://mediainfo.sourceforge.net/Support/SDK, MediaInfo)
 * License:
 * This wrapper $(LINK2 http://www.boost.org/LICENSE_1_0.txt, Boost License 1.0)
 * MediaInfo $(LINK2 http://www.gnu.org/licenses/lgpl-3.0.txt, LGPL 3.0)
 * Authors: Johannes Pfau, Carsten Schlote
 */
module mediainfo;

import std.string;
import std.conv;
import std.typecons;

import mediainfodll;

//public alias MediaInfo_stream_t Stream;
//public alias MediaInfo_info_t Info;

/** A exception of the mediainfo wrapper */
public class MediaInfoException : Exception
{
    public this(string msg)
    {
        super(msg);
    }
}

/** This is the UTF Wrapper for libmediainfo */
public struct MediaInfo
{
private:
    struct Payload
    {
        void* _payload;
        this(void* h)
        {
            _payload = h;
        }
        ~this()
        {
            if(_payload)
            {
                mediainfo_FunctionTable.MediaInfo_Delete(_payload);
                _payload = null;
				MediaInfoDLL_UnLoad();
            }
        }
        // Should never perform these operations
        this(this) { assert(false); }
        void opAssign(MediaInfo.Payload rhs) { assert(false); }
    }

    alias Data = RefCounted!(Payload, RefCountedAutoInitialize.no);
    Data _data;

    @property void* handle()
    {
        return _data._payload;
    }

public:

    /** Use call operator to initialize resource */
    static MediaInfo opCall()
    {
        MediaInfo info;
        auto rc = MediaInfoDLL_Load();
        if(rc != 1) {
            throw new MediaInfoException("Couldn't open mediainfo library");
        }

        auto h = mediainfo_FunctionTable.MediaInfo_New();
        info._data.refCountedStore.ensureInitialized();
        info._data._payload = h;
        return info;
    }

    /**
     * Open a file.
     * Open a file and collect information about it (technical information and tags)
     *
     * Parameters:
     * fileName = Full name of file to open
     */
    void open(string fileName)
    {
        version(Workaround_UTF_Bug) {
            import std.stdio : File;
            auto fh = File(fileName);
            scope(exit) fh.close;
            this.openBufferInit(fh.size, 0);

            //The parsing loop
            ubyte[4096] rawbuffer;
            ubyte[] buffer;
            do
            {
                // Read some data to buffer...
                buffer = fh.rawRead(rawbuffer);
                // Sending the buffer to MediaInfo
                auto status = this.openBufferContinue(buffer.ptr, buffer.length);
                if (status&0x08) //Bit3=Finished
                    break;
                // Testing if there is a MediaInfo request to go elsewhere
                if (this.openBufferContinueGoToGet() != -1 )
                {
                    // Position the file
                    import core.stdc.stdio : SEEK_SET;
                    fh.seek(this.openBufferContinueGoToGet(), SEEK_SET);
                    // Informing MediaInfo we have seek
                    this.openBufferInit(fh.size, fh.tell);
                }
            }
            while (buffer.length > 0);
            //This is the end of the stream, MediaInfo must finnish some work
            this.openBufferFinalize();
        }
        else {
            static MediaInfo_Char* _fileNameRef;
            import std.utf;
            auto  filename = fileName.toUTFz!(MediaInfo_Char*);
            auto rc = mediainfo_FunctionTable.MediaInfo_Open(handle, filename);
            if(!rc)
            {
                throw new MediaInfoException("Couldn't open file: " ~ fileName);
            }
            _fileNameRef = fileName;
        }
    }
/+        /**
     * Open a buffer.
     * Open a Buffer (Begin and end of the stream) and collect information about it (technical information and tags)
     * Params:
     * begin = First bytes of the buffer
     * begin_size = Size of Begin
     * end = Last bytes of the buffer
     * end_size = Size of End
     * file_size = Total size of the file
     */
    void open(ubyte* begin, size_t begin_size, ubyte* end, size_t end_size)
    {
        if(MediaInfo_Open_Buffer(handle, begin, begin_size, end, end_size))
        {
            throw new MediaInfoException("Couldn't open file from buffer");
        }
    }
+/
    /**
     * Open a stream (Init).
     *
     * Open a stream and collect information about it (technical information and tags)
     *
     * Params:
     * fileSize = Estimated file size
     * fileOffset = Offset of the file (if we don't have the beginning of the file)
     */
    size_t openBufferInit(long fileSize = -1, long fileOffset = 0)
    {
        return mediainfo_FunctionTable.MediaInfo_Open_Buffer_Init(handle, fileSize, fileOffset);
    }
    /**
     * Open a stream (Continue).
     *
     * Open a stream and collect information about it (technical information and tags)
     *
     * Params:
     * buffer = pointer to the stream
     * size =Count of bytes to read
     */
    size_t openBufferContinue(ubyte* buffer, size_t size)
    {
        return mediainfo_FunctionTable.MediaInfo_Open_Buffer_Continue(handle, buffer, size);
    }
    /**
     * Open a stream (Get the needed file Offset).
     *
     * Open a stream and collect information about it (technical information and tags)
     *
     * Returns:
     * the needed offset of the file
     * File size if no more bytes are needed
     */
    long openBufferContinueGoToGet()
    {
        return mediainfo_FunctionTable.MediaInfo_Open_Buffer_Continue_GoTo_Get(handle);
    }
    /**
     * Open a stream (Finalize).
     *
     * Open a stream and collect information about it (technical information and tags)
     */
    size_t openBufferFinalize()
    {
        return mediainfo_FunctionTable.MediaInfo_Open_Buffer_Finalize(handle);
    }
/+        /**
     * (NOT IMPLEMENTED YET) Save the file
     *
     * (NOT IMPLEMENTED YET) Save the file opened before with Open() (modifications of tags)
     */
    void save()
    {
        if(mediainfo_FunctionTable.MediaInfo_Save(handle))
        {
            throw new MediaInfoException("Couldn't save file");
        }
    }
+/
    /**
     * Close a file.
     *
     * Close a file opened before with Open() (without saving)
     *
     * Warning:
     * without have saved before, modifications are lost
     */
    void close()
    {
        mediainfo_FunctionTable.MediaInfo_Close(handle);
        version(Workaround_UTF_Bug) {} else _fileNameRef = null;
    }
    /**
     * String MediaInfoLib::MediaInfo::Inform   (   size_t  Reserved = 0     )
     * Get all details about a file.
     *
     * Get all details about a file in one string
     *
     * Precondition:
     * You can change default presentation with Inform_Set()
     */
    string inform(size_t reserved = 0)
    {
        import std.utf;
        auto strptr = mediainfo_FunctionTable.MediaInfo_Inform(handle, reserved);
        auto str = strptr.fromStringz;
        return to!string(str);
    }
    /**
     * Get a piece of information about a file (parameter is an integer).
     *
     * Get a piece of information about a file (parameter is an integer)
     *
     * Params:
     * streamKind = Kind of stream (general, video, audio...)
     * streamNumber = Stream number in Kind of stream (first, second...)
     * parameter = Parameter you are looking for in the stream (Codec, width, bitrate...), in integer format (first parameter, second parameter...)
     * infoKind = Kind of information you want about the parameter (the text, the measure, the help...)
     * Returns:
     * a string about information you search
     * an empty string if there is a problem
     */
    string get(MediaInfo_stream_t streamKind, size_t streamNumber, size_t parameter,
        MediaInfo_info_t infoKind = MediaInfo_info_t.MediaInfo_Info_Text)
    {
        import std.utf;
        auto strptr = mediainfo_FunctionTable.MediaInfo_GetI(handle, streamKind, streamNumber,
            parameter, infoKind);
        auto str = strptr.fromStringz;
        return to!string(str);
    }
    /**
     * Get a piece of information about a file (parameter is a string).
     *
     * Get a piece of information about a file (parameter is a string)
     *
     * Params:
     * streamKind = Kind of stream (general, video, audio...)
     * streamNumber = Stream number in Kind of stream (first, second...)
     * parameter = Parameter you are looking for in the stream (Codec, width, bitrate...), in string format ("Codec", "Width"...)
     * See MediaInfo::Option("Info_Parameters") to have the full list
     * infoKind = Kind of information you want about the parameter (the text, the measure, the help...)
     * searchKind = Where to look for the parameter
     * Returns:
     * a string about information you search
     * an empty string if there is a problem
     */
    string get(MediaInfo_stream_t streamKind, size_t streamNumber,
        string parameter, MediaInfo_info_t infoKind = MediaInfo_info_t.MediaInfo_Info_Text,
        MediaInfo_info_t searchKind = MediaInfo_info_t.MediaInfo_Info_Name)
    {
        import std.utf;
        MediaInfo_Char* parameterZ = parameter.toUTFz!(MediaInfo_Char*);
        const auto strptr = mediainfo_FunctionTable.MediaInfo_Get(handle, streamKind, streamNumber, parameterZ, infoKind, searchKind);
        auto str = strptr.fromStringz;
        return to!string(str);
    }
/+        /**
     * (NOT IMPLEMENTED YET) Set a piece of information about a file (parameter is an int)
     *
     * (NOT IMPLEMENTED YET) Set a piece of information about a file (parameter is an integer)
     *
     * Warning:
     * Not yet implemented, do not use it
     * Params:
     * toSet = Piece of information
     * streamKind = Kind of stream (general, video, audio...)
     * streamNumber = Stream number in Kind of stream (first, second...)
     * parameter = Parameter you are looking for in the stream (Codec, width, bitrate...), in integer format (first parameter, second parameter...)
     * oldValue = The old value of the parameter
     * if OldValue is empty and ToSet is filled: tag is added
     * if OldValue is filled and ToSet is filled: tag is replaced
     * if OldValue is filled and ToSet is empty: tag is deleted
     */
    void set(const(string) toSet, Stream streamKind, size_t streamNumber,
        size_t parameter, const(string) oldValue = "")
    {
        if(!mediainfo_FunctionTable.MediaInfo_SetI(handle, toStringz(toSet), streamKind, streamNumber,
            parameter, toStringz(oldValue)))
        {
            throw new MediaInfoException("Couldn't set parameter");
        }
    }
    /**
     * (NOT IMPLEMENTED YET) Set information about a file (parameter is a string)
     *
     * (NOT IMPLEMENTED YET) Set a piece of information about a file (parameter is a string)
     *
     * Warning:
     * Not yet implemented, do not use it
     * Params:
     * toSet = Piece of information
     * streamKind = Kind of stream (general, video, audio...)
     * streamNumber = Stream number in Kind of stream (first, second...)
     * parameter = Parameter you are looking for in the stream (Codec, width, bitrate...), in string format
     * oldValue = The old value of the parameter
     * if OldValue is empty and ToSet is filled: tag is added
     * if OldValue is filled and ToSet is filled: tag is replaced
     * if OldValue is filled and ToSet is empty: tag is deleted
     */
    void set(const(string) toSet, Stream streamKind, size_t streamNumber,
        const(string) parameter, const(string) oldValue = "")
    {
        if(!mediainfo_FunctionTable.MediaInfo_Set(handle, toStringz(toSet), streamKind, streamNumber,
            toStringz(parameter), toStringz(oldValue)))
        {
            throw new MediaInfoException("Couldn't set parameter");
        }
    }
+/
    /**
     * Output the written size when "File_Duplicate" option is used.
     *
     * Output the written size when "File_Duplicate" option is used.
     *
     * Params:
     * value = The unique name of the duplicated stream (begin with "memory://")
     * Returns:
     * The size of the used buffer
     */
    size_t outputBufferGet(const(string) value)
    {
        import std.utf;
        MediaInfo_Char* valueZ = value.toUTFz!(MediaInfo_Char*);
        return mediainfo_FunctionTable.MediaInfo_Output_Buffer_Get(handle, valueZ);
    }
    /**
     * Output the written size when "File_Duplicate" option is used.
     *
     * Output the written size when "File_Duplicate" option is used.
     *
     * Params:
     * pos = The position ?
     * Returns:
     * The size of the used buffer
     */
    size_t outputBufferGet(size_t pos)
    {
        return mediainfo_FunctionTable.MediaInfo_Output_Buffer_GetI(handle, pos);
    }
    /**
     * Configure or get information about MediaInfoLib
     *
     * Params:
     * option = The name of option
     * value = The value of option
     * Returns:
     * Depend of the option: by default "" (nothing) means No, other means Yes
     */
    string option(const(string) option, const(string) value = "")
    {
        import std.utf;
        MediaInfo_Char* optionZ = option.toUTFz!(MediaInfo_Char*);
        MediaInfo_Char* valueZ = value.toUTFz!(MediaInfo_Char*);
        auto strptr = mediainfo_FunctionTable.MediaInfo_Option(handle, optionZ, valueZ);
        auto str = strptr.fromStringz;
        return to!string(str);
    }

    /*
    static string optionStatic(const(string) option, const(string) value = "")
    {
        return to!string(mediainfo_FunctionTable.MediaInfo_Option_Static(handle, toStringz(option), toStringz(value)));
    }*/

    /**
     * (NOT IMPLEMENTED YET) Get the state of the library
     *
     * Return values:
     * <1000    No information is available for the file yet
     * >=1000_<5000     Only local (into the file) information is available, getting Internet information (titles only) is no finished yet
     * 5000     (only if Internet connection is accepted) User interaction is needed (use Option() with "Internet_Title_Get")
     * Warning: even there is only one possible, user interaction (or the software) is needed
     * >5000<=10000     Only local (into the file) information is available, getting Internet information (all) is no finished yet
     * <10000   Done
     */
    size_t getState()
    {
        return mediainfo_FunctionTable.MediaInfo_State_Get(handle);
    }
    /**
     * Count of streams of a stream kind (StreamNumber not filled), or count of piece of information in this stream.
     *
     * Params:
     * streamKind = Kind of stream (general, video, audio...)
     * streamNumber = Stream number in this kind of stream (first, second...)
     */
    size_t getCount(MediaInfo_stream_t streamKind, size_t streamNumber = -1)
    {
        return mediainfo_FunctionTable.MediaInfo_Count_Get(handle, streamKind, streamNumber);
    }
}
