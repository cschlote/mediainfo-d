/*  Copyright (c) MediaArea.net SARL. All Rights Reserved.
 *
 *  Use of this source code is governed by a BSD-style license that can
 *  be found in the License.html file in the root of the source tree.
 */

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
// Public DLL interface implementation
// Wrapper for MediaInfo Library
// See MediaInfo.h for help
//
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

extern (C):
import core.stdc.config;

/* Char types                                                              */
version(MediaInfo_UTF)
{
	version(Windows) {
		enum MEDIAINFO_Ansi = "";
		alias MediaInfo_Char = wchar;
	}
	else {
		enum MEDIAINFO_Ansi = "";
		alias MediaInfo_Char = dchar;
	}
}
else {
	enum MEDIAINFO_Ansi = "A";
	alias MediaInfo_Char = char;
}

/* 8-bit int                                                               */
alias MediaInfo_int8u = ubyte;

/* 64-bit int                                                              */
enum MAXTYPE_INT = 64;
alias MediaInfo_int64u = ulong;

/*-------------------------------------------------------------------------*/

/** @brief Kinds of Stream */
enum MediaInfo_stream_t
{
    MediaInfo_Stream_General = 0,
    MediaInfo_Stream_Video = 1,
    MediaInfo_Stream_Audio = 2,
    MediaInfo_Stream_Text = 3,
    MediaInfo_Stream_Other = 4,
    MediaInfo_Stream_Image = 5,
    MediaInfo_Stream_Menu = 6,
    MediaInfo_Stream_Max = 7
}

/** @brief Kinds of Info */
enum MediaInfo_info_t
{
    MediaInfo_Info_Name = 0,
    MediaInfo_Info_Text = 1,
    MediaInfo_Info_Measure = 2,
    MediaInfo_Info_Options = 3,
    MediaInfo_Info_Name_Text = 4,
    MediaInfo_Info_Measure_Text = 5,
    MediaInfo_Info_Info = 6,
    MediaInfo_Info_HowTo = 7,
    MediaInfo_Info_Max = 8
}

/** @brief Option if InfoKind = Info_Options */
enum MediaInfo_infooptions_t
{
    MediaInfo_InfoOption_ShowInInform = 0,
    MediaInfo_InfoOption_Reserved = 1,
    MediaInfo_InfoOption_ShowInSupported = 2,
    MediaInfo_InfoOption_TypeOfValue = 3,
    MediaInfo_InfoOption_Max = 4
}

/** @brief File opening options */
enum MediaInfo_fileoptions_t
{
    MediaInfo_FileOption_Nothing = 0x00,
    MediaInfo_FileOption_NoRecursive = 0x01,
    MediaInfo_FileOption_CloseAll = 0x02,
    MediaInfo_FileOption_Max = 0x04
}

/* Functions using wide string (UTF16 (windows) or UTF32 (posix)) */
version(MediaInfo_UTF)
{
    extern __gshared void* MediaInfo_New();
    extern __gshared void* MediaInfoList_New();
    extern __gshared void MediaInfo_Delete (void*);
    extern __gshared void MediaInfoList_Delete (void*);
    extern __gshared c_ulong MediaInfoList_Open (void*, const(MediaInfo_Char)*, const MediaInfo_fileoptions_t);
    extern __gshared c_ulong MediaInfo_Open (void*, const(MediaInfo_Char)*);
    extern __gshared c_ulong  MediaInfo_Open_Buffer_Init (void*, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset);
    extern __gshared c_ulong MediaInfo_Open_Buffer_Continue (void*, MediaInfo_int8u* Buffer, size_t Buffer_Size);
    extern __gshared ulong MediaInfo_Open_Buffer_Continue_GoTo_Get (void*);
    extern __gshared c_ulong MediaInfo_Open_Buffer_Finalize (void*);
    extern __gshared c_ulong MediaInfo_Open_NextPacket (void*);
    extern __gshared void MediaInfo_Close (void*);
    extern __gshared void MediaInfoList_Close (void*, size_t);
    extern __gshared const(MediaInfo_Char)* MediaInfo_Inform (void*, size_t Reserved);
    extern __gshared const(MediaInfo_Char)* MediaInfoList_Inform (void*, size_t, size_t Reserved);
    extern __gshared const(MediaInfo_Char)* MediaInfo_GetI (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_t KindOfInfo);
    extern __gshared const(MediaInfo_Char)* MediaInfoList_GetI (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_t KindOfInfo);
    extern __gshared const(MediaInfo_Char)* MediaInfo_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_t KindOfInfo, MediaInfo_info_t KindOfSearch);
    extern __gshared const(MediaInfo_Char)* MediaInfoList_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_t KindOfInfo, MediaInfo_info_t KindOfSearch);
    extern __gshared c_ulong MediaInfo_Output_Buffer_Get (void*, const(MediaInfo_Char)* Parameter);
    extern __gshared c_ulong MediaInfo_Output_Buffer_GetI (void*, size_t Pos);
    extern __gshared const(MediaInfo_Char)* MediaInfo_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared const(MediaInfo_Char)* MediaInfoList_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared c_ulong MediaInfo_State_Get (void*);
    extern __gshared c_ulong MediaInfoList_State_Get (void*);
    extern __gshared c_ulong MediaInfo_Count_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfoList_Count_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfo_Count_Get_Files (void*);
    extern __gshared c_ulong MediaInfoList_Count_Get_Files (void*);
}
else
{
    /* Functions using Ansi C-Strings (7Bit chars!) - no locale support, codepage on windows */
    extern __gshared void* MediaInfoA_New();
    extern __gshared void* MediaInfoListA_New();
    extern __gshared void MediaInfoA_Delete (void*);
    extern __gshared void MediaInfoListA_Delete (void*);
    extern __gshared c_ulong MediaInfoA_Open (void*, const(MediaInfo_Char)*);
    extern __gshared c_ulong MediaInfoListA_Open (void*, const(MediaInfo_Char)*, const MediaInfo_fileoptions_t);
    extern __gshared c_ulong  MediaInfoA_Open_Buffer_Init (void*, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset);
    extern __gshared c_ulong MediaInfoA_Open_Buffer_Continue (void*, MediaInfo_int8u* Buffer, size_t Buffer_Size);
    extern __gshared ulong MediaInfoA_Open_Buffer_Continue_GoTo_Get (void*);
    extern __gshared c_ulong MediaInfoA_Open_Buffer_Finalize (void*);
    extern __gshared c_ulong MediaInfoA_Open_NextPacket (void*);
    extern __gshared void MediaInfoA_Close (void*);
    extern __gshared void MediaInfoListA_Close (void*, size_t);
    extern __gshared const(char)* MediaInfoA_Inform (void*, size_t Reserved);
    extern __gshared const(char)* MediaInfoListA_Inform (void*, size_t, size_t Reserved);
    extern __gshared const(char)* MediaInfoA_GetI (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_t KindOfInfo);
    extern __gshared const(char)* MediaInfoListA_GetI (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_t KindOfInfo);
    extern __gshared const(char)* MediaInfoA_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_t KindOfInfo, MediaInfo_info_t KindOfSearch);
    extern __gshared const(char)* MediaInfoListA_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_t KindOfInfo, MediaInfo_info_t KindOfSearch);
    extern __gshared c_ulong MediaInfoA_Output_Buffer_Get (void*, const(MediaInfo_Char)* Parameter);
    extern __gshared c_ulong MediaInfoA_Output_Buffer_GetI (void*, size_t Pos);
    extern __gshared const(char)* MediaInfoA_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared const(char)* MediaInfoListA_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared c_ulong MediaInfoA_State_Get (void*);
    extern __gshared c_ulong MediaInfoListA_State_Get (void*);
    extern __gshared c_ulong MediaInfoA_Count_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfoListA_Count_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfoA_Count_Get_Files (void*);
    extern __gshared c_ulong MediaInfoListA_Count_Get_Files (void*);
}

/* Module loader support */

version(MEDIAINFO_GLIBC) {
    template MEDIAINFO_ASSIGN(string _Name) {
        void MEDIAINFO_ASSIGN(ref size_t Errors) {
            auto rv = g_module_symbol (MediaInfo_Module, "MediaInfo" ~ MEDIAINFO_Ansi ~ "_" ~_Name, mixin("cast(gpointer*) & mediainfo_FunctionTable.MediaInfo_" ~ _Name ~")" ));
            if (!rv) Errors++;
        }
    }
    template MEDIAINFOLIST_ASSIGN(string _Name) {
        void MEDIAINFOLIST_ASSIGN(ref size_t Errors) {
            auto rv = g_module_symbol (MediaInfo_Module, "MediaInfoList" ~ MEDIAINFO_Ansi ~ "_" ~_Name, mixin("cast(gpointer*) & mediainfo_FunctionTable.MediaInfoList_" ~ _Name ~")" ));
            if (!rv) Errors++;
        }
    }
} else version(WINDOWS) {
    template MEDIAINFO_ASSIGN(string _Name) {
        void MEDIAINFO_ASSIGN(ref size_t Errors) {
            auto rv = GetProcAddress(MediaInfo_Module, "MediaInfo" ~ MEDIAINFO_Ansi ~ "_" ~ _Name);
            mixin("mediainfo_FunctionTable.MediaInfo_" ~ _Name) = mixin("cast(MEDIAINFO" ~ MEDIAINFO_Ansi ~ "_" ~ _Name ~ ")rv");
            if (mixin("mediainfo_FunctionTable.MediaInfo_" ~ _Name) == null) Errors++;
        }
    }
    template MEDIAINFOLIST_ASSIGN(string _Name) {
        void MEDIAINFOLIST_ASSIGN(ref size_t Errors) {
            auto rv = GetProcAddress(MediaInfo_Module, "MediaInfoList" ~ MEDIAINFO_Ansi ~ "_" ~ _Name);
            mixin("mediainfo_FunctionTable.MediaInfoList_" ~ _Name) = mixin("cast(MEDIAINFOLIST" ~ MEDIAINFO_Ansi ~ "_" ~ _Name ~ ")rv");
            if (mixin("mediainfo_FunctionTable.MediaInfoList_" ~ _Name) == null) Errors++;
        }
    }
} else {
    template MEDIAINFO_ASSIGN(string _Name) {
        void MEDIAINFO_ASSIGN(ref size_t Errors) {
            auto rv = dlsym(MediaInfo_Module, "MediaInfo" ~ MEDIAINFO_Ansi ~ "_" ~ _Name);
            mixin("mediainfo_FunctionTable.MediaInfo_" ~ _Name) = mixin("cast(MEDIAINFO" ~ MEDIAINFO_Ansi ~ "_" ~ _Name ~ ")rv");
            if (mixin("mediainfo_FunctionTable.MediaInfo_" ~ _Name) is null) Errors++;
        }
    }
    template MEDIAINFOLIST_ASSIGN(string _Name) {
        void MEDIAINFOLIST_ASSIGN(ref size_t Errors) {
            auto rv = dlsym(MediaInfo_Module, "MediaInfoList" ~ MEDIAINFO_Ansi ~ "_" ~ _Name);
            mixin("mediainfo_FunctionTable.MediaInfoList_" ~ _Name) = mixin("cast(MEDIAINFOLIST" ~ MEDIAINFO_Ansi ~ "_" ~ _Name ~ ")rv");
            if (mixin("mediainfo_FunctionTable.MediaInfoList_" ~ _Name) is null) Errors++;
        }
    }
}

/* Define function pointer types - use either Ansi or wchar API here */

alias MEDIAINFO_New = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_New"))*;
alias MEDIAINFOLIST_New = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_New"))*;
alias MEDIAINFO_Delete = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Delete"))*;
alias MEDIAINFOLIST_Delete = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Delete"))*;
alias MEDIAINFO_Open = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open"))*;
alias MEDIAINFOLIST_Open = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Open"))*;
alias MEDIAINFO_Open_Buffer_Init = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open_Buffer_Init"))*;
alias MEDIAINFO_Open_Buffer_Continue = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open_Buffer_Continue"))*;
alias MEDIAINFO_Open_Buffer_Continue_GoTo_Get = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open_Buffer_Continue_GoTo_Get"))*;
alias MEDIAINFO_Open_Buffer_Finalize = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open_Buffer_Finalize"))*;
alias MEDIAINFO_Open_NextPacket = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Open_NextPacket"))*;
alias MEDIAINFO_Close = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Close"))*;
alias MEDIAINFOLIST_Close = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Close"))*;
alias MEDIAINFO_Inform = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Inform"))*;
alias MEDIAINFOLIST_Inform = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Inform"))*;
alias MEDIAINFO_GetI = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_GetI"))*;
alias MEDIAINFOLIST_GetI = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_GetI"))*;
alias MEDIAINFO_Get = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Get"))*;
alias MEDIAINFOLIST_Get = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Get"))*;
alias MEDIAINFO_Output_Buffer_Get = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Output_Buffer_Get"))*;
alias MEDIAINFO_Output_Buffer_GetI = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Output_Buffer_GetI"))*;
alias MEDIAINFO_Option = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Option"))*;
alias MEDIAINFOLIST_Option = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Option"))*;
alias MEDIAINFO_State_Get = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_State_Get"))*;
alias MEDIAINFOLIST_State_Get = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_State_Get"))*;
alias MEDIAINFO_Count_Get = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Count_Get"))*;
alias MEDIAINFOLIST_Count_Get = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Count_Get"))*;
alias MEDIAINFO_Count_Get_Files = typeof(mixin("MediaInfo" ~ MEDIAINFO_Ansi ~ "_Count_Get_Files"))*;
alias MEDIAINFOLIST_Count_Get_Files = typeof(mixin("MediaInfoList" ~ MEDIAINFO_Ansi ~ "_Count_Get_Files"))*;

/*  A structure holding all the function pointers to the library - either UTF or Ansi API */

struct MediaInfo_FunctionTable
{
    MEDIAINFO_New MediaInfo_New;
    MEDIAINFOLIST_New MediaInfoList_New;
    MEDIAINFO_Delete MediaInfo_Delete;
    MEDIAINFOLIST_Delete MediaInfoList_Delete;
    MEDIAINFO_Open MediaInfo_Open;
    MEDIAINFOLIST_Open MediaInfoList_Open;
    MEDIAINFO_Open_Buffer_Init MediaInfo_Open_Buffer_Init;
    MEDIAINFO_Open_Buffer_Continue MediaInfo_Open_Buffer_Continue;
    MEDIAINFO_Open_Buffer_Continue_GoTo_Get MediaInfo_Open_Buffer_Continue_GoTo_Get;
    MEDIAINFO_Open_Buffer_Finalize MediaInfo_Open_Buffer_Finalize;
    MEDIAINFO_Open_NextPacket MediaInfo_Open_NextPacket;
    MEDIAINFO_Close MediaInfo_Close;
    MEDIAINFOLIST_Close MediaInfoList_Close;
    MEDIAINFO_Inform MediaInfo_Inform;
    MEDIAINFOLIST_Inform MediaInfoList_Inform;
    MEDIAINFO_GetI MediaInfo_GetI;
    MEDIAINFOLIST_GetI MediaInfoList_GetI;
    MEDIAINFO_Get MediaInfo_Get;
    MEDIAINFOLIST_Get MediaInfoList_Get;
    MEDIAINFO_Output_Buffer_Get MediaInfo_Output_Buffer_Get;
    MEDIAINFO_Output_Buffer_GetI MediaInfo_Output_Buffer_GetI;
    MEDIAINFO_Option MediaInfo_Option;
    MEDIAINFOLIST_Option MediaInfoList_Option;
    MEDIAINFO_State_Get MediaInfo_State_Get;
    MEDIAINFOLIST_State_Get MediaInfoList_State_Get;
    MEDIAINFO_Count_Get MediaInfo_Count_Get;
    MEDIAINFOLIST_Count_Get MediaInfoList_Count_Get;
    MEDIAINFO_Count_Get_Files MediaInfo_Count_Get_Files;
    MEDIAINFOLIST_Count_Get_Files MediaInfoList_Count_Get_Files;
}

shared MediaInfo_FunctionTable mediainfo_FunctionTable;

version(WINDOWS)
    enum MEDIAINFODLL_NAME = "MediaInfo.dll";
else {
    enum MEDIAINFODLL_NAME = "libmediainfo.so.0";
}
extern(C) {
    shared(void *) dlopen(const char *filename, int flag);
    char *dlerror();
    void *dlsym(shared void *handle, const char *symbol);
    int dlclose(shared void *handle);
}
enum RTLD_LAZY = 0x00001;
shared void* MediaInfo_Module = null;
shared size_t Module_Count = 0;

static import core.atomic;

size_t MediaInfoDLL_Load()
{
    size_t Errors = 0;

    if (Module_Count > 0) {
        core.atomic.atomicOp!"+="(Module_Count, 1);
        return 1;
    }

    /* Load library */
    version(MEDIAINFO_GLIBC) {
        MediaInfo_Module = g_module_open(MEDIAINFODLL_NAME, G_MODULE_BIND_LAZY);
    } else version(WINDOWS) {
        MediaInfo_Module = LoadLibrary(MEDIAINFODLL_NAME);
    } else {
        version(MACOSX) {
            MediaInfo_Module = dlopen("@executable_path/" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
            if (!MediaInfo_Module)
            {
                CFBundleRef mainBundle = CFBundleGetMainBundle();

                // get full app path and delete app name
                CFURLRef app_url = CFBundleCopyExecutableURL(mainBundle);
                CFURLRef app_path_url = CFURLCreateCopyDeletingLastPathComponent(NULL, app_url);

                CFStringRef app_path = CFURLCopyFileSystemPath(app_path_url, kCFURLPOSIXPathStyle);

                CFMutableStringRef mut_app_path = CFStringCreateMutableCopy(NULL, NULL, app_path);
                CFStringAppend(mut_app_path, CFSTR("/"));
                CFStringAppend(mut_app_path, CFSTR(MEDIAINFODLL_NAME));
                CFStringEncoding encodingMethod = CFStringGetSystemEncoding();
                const char *fullPath = CFStringGetCStringPtr(mut_app_path, encodingMethod);

                MediaInfo_Module = dlopen(fullPath, RTLD_LAZY);

                CFRelease(app_url);
                CFRelease(app_path_url);
                CFRelease(app_path);
                CFRelease(mut_app_path);
            }
        } /* MACOSX*/

        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen(MEDIAINFODLL_NAME, RTLD_LAZY);
        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen("./" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen("/usr/local/lib/" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen("/usr/local/lib64/" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen("/usr/lib/" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
        if (!MediaInfo_Module)
            MediaInfo_Module = dlopen("/usr/lib64/" ~ MEDIAINFODLL_NAME, RTLD_LAZY);
    }
        if (!MediaInfo_Module)
            return - 1;

    /* Load function pointers */

    MEDIAINFO_ASSIGN!("New")(Errors);
    MEDIAINFOLIST_ASSIGN!("New")(Errors);
    MEDIAINFO_ASSIGN!("Delete")(Errors);
    MEDIAINFOLIST_ASSIGN!("Delete")(Errors);
    MEDIAINFO_ASSIGN!("Open")(Errors);
    MEDIAINFOLIST_ASSIGN!("Open")(Errors);
    MEDIAINFO_ASSIGN!("Open_Buffer_Init")(Errors);
    MEDIAINFO_ASSIGN!("Open_Buffer_Continue")(Errors);
    MEDIAINFO_ASSIGN!("Open_Buffer_Continue_GoTo_Get")(Errors);
    MEDIAINFO_ASSIGN!("Open_Buffer_Finalize")(Errors);
    MEDIAINFO_ASSIGN!("Open_NextPacket")(Errors);
    MEDIAINFO_ASSIGN!("Close")(Errors);
    MEDIAINFOLIST_ASSIGN!("Close")(Errors);
    MEDIAINFO_ASSIGN!("Inform")(Errors);
    MEDIAINFOLIST_ASSIGN!("Inform")(Errors);
    MEDIAINFO_ASSIGN!("GetI")(Errors);
    MEDIAINFOLIST_ASSIGN!("GetI")(Errors);
    MEDIAINFO_ASSIGN!("Get")(Errors);
    MEDIAINFOLIST_ASSIGN!("Get")(Errors);
    MEDIAINFO_ASSIGN!("Output_Buffer_Get")(Errors);
    MEDIAINFO_ASSIGN!("Output_Buffer_GetI")(Errors);
    MEDIAINFO_ASSIGN!("Option")(Errors);
    MEDIAINFOLIST_ASSIGN!("Option")(Errors);
    MEDIAINFO_ASSIGN!("State_Get")(Errors);
    MEDIAINFOLIST_ASSIGN!("State_Get")(Errors);
    MEDIAINFO_ASSIGN!("Count_Get")(Errors);
    MEDIAINFOLIST_ASSIGN!("Count_Get")(Errors);
    MEDIAINFOLIST_ASSIGN!("Count_Get_Files")(Errors);

    if (Errors > 0) {
        // Unload DLL with errors
        version(MEDIAINFO_GLIBC) {
            g_module_close(MediaInfo_Module);
        } else version(WINDOWS) {
            FreeLibrary(MediaInfo_Module);
        } else {
            dlclose(MediaInfo_Module);
            MediaInfo_Module = null;
            return - 1;
        }
    }
    core.atomic.atomicOp!("+=")(Module_Count, 1);
    return 1;
}

size_t MediaInfoDLL_IsLoaded()
{
    if (MediaInfo_Module)
        return 1;
    else
        return 0;
}

void MediaInfoDLL_UnLoad()
{
    core.atomic.atomicOp!("-=")(Module_Count, 1);
    if (Module_Count > 0)
        return;

    version(MEDIAINFO_GLIBC)
        g_module_close(MediaInfo_Module);
    else version(WINDOWS)
        FreeLibrary(MediaInfo_Module);
    else {
        dlclose(MediaInfo_Module);
    }
    MediaInfo_Module = null;
}

