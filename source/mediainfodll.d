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


//***************************************************************************
// Platforms (from libzen)
//***************************************************************************

enum __UNIX__ = 1;

enum MEDIAINFODLL_NAME = "libmediainfo.so.0";

/*-------------------------------------------------------------------------*/
/*Char types                                                               */

alias MediaInfo_Char = char;
enum MEDIAINFO_Ansi = "A";

/*-------------------------------------------------------------------------*/
/*8-bit int                                                                */
alias MediaInfo_int8u = ubyte;

/*-------------------------------------------------------------------------*/
/*64-bit int                                                               */

enum MAXTYPE_INT = 64;
alias MediaInfo_int64u = ulong;

/*-------------------------------------------------------------------------*/
/*NULL                                                                     */
enum NULL = 0;

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

alias MediaInfo_stream_C = MediaInfo_stream_t;

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

alias MediaInfo_info_C = MediaInfo_info_t;

/** @brief Option if InfoKind = Info_Options */
enum MediaInfo_infooptions_t
{
    MediaInfo_InfoOption_ShowInInform = 0,
    MediaInfo_InfoOption_Reserved = 1,
    MediaInfo_InfoOption_ShowInSupported = 2,
    MediaInfo_InfoOption_TypeOfValue = 3,
    MediaInfo_InfoOption_Max = 4
}

alias MediaInfo_infooptions_C = MediaInfo_infooptions_t;

/** @brief File opening options */
enum MediaInfo_fileoptions_t
{
    MediaInfo_FileOption_Nothing = 0x00,
    MediaInfo_FileOption_NoRecursive = 0x01,
    MediaInfo_FileOption_CloseAll = 0x02,
    MediaInfo_FileOption_Max = 0x04
}

alias MediaInfo_fileoptions_C = MediaInfo_fileoptions_t;

/* __cplusplus */

extern __gshared void* MediaInfo_Module;

extern __gshared size_t Module_Count;

alias MEDIAINFO_New = void* function ();
extern __gshared MEDIAINFO_New MediaInfo_New;
alias MEDIAINFOLIST_New = void* function ();
extern __gshared MEDIAINFOLIST_New MediaInfoList_New;
alias MEDIAINFO_Delete = void function (void*);
extern __gshared MEDIAINFO_Delete MediaInfo_Delete;
alias MEDIAINFOLIST_Delete = void function (void*);
extern __gshared MEDIAINFOLIST_Delete MediaInfoList_Delete;
alias MEDIAINFO_Open = c_ulong function (void*, const(MediaInfo_Char)*);
extern __gshared MEDIAINFO_Open MediaInfo_Open;
alias MEDIAINFOLIST_Open = c_ulong function (void*, const(MediaInfo_Char)*, const MediaInfo_fileoptions_C);
extern __gshared MEDIAINFOLIST_Open MediaInfoList_Open;
alias MEDIAINFO_Open_Buffer_Init = c_ulong function (void*, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset);
extern __gshared MEDIAINFO_Open_Buffer_Init MediaInfo_Open_Buffer_Init;
alias MEDIAINFO_Open_Buffer_Continue = c_ulong function (void*, MediaInfo_int8u* Buffer, size_t Buffer_Size);
extern __gshared MEDIAINFO_Open_Buffer_Continue MediaInfo_Open_Buffer_Continue;
alias MEDIAINFO_Open_Buffer_Continue_GoTo_Get = ulong function (void*);
extern __gshared MEDIAINFO_Open_Buffer_Continue_GoTo_Get MediaInfo_Open_Buffer_Continue_GoTo_Get;
alias MEDIAINFO_Open_Buffer_Finalize = c_ulong function (void*);
extern __gshared MEDIAINFO_Open_Buffer_Finalize MediaInfo_Open_Buffer_Finalize;
alias MEDIAINFO_Open_NextPacket = c_ulong function (void*);
extern __gshared MEDIAINFO_Open_NextPacket MediaInfo_Open_NextPacket;
alias MEDIAINFO_Close = void function (void*);
extern __gshared MEDIAINFO_Close MediaInfo_Close;
alias MEDIAINFOLIST_Close = void function (void*, size_t);
extern __gshared MEDIAINFOLIST_Close MediaInfoList_Close;
alias MEDIAINFO_Inform = const(char)* function (void*, size_t Reserved);
extern __gshared MEDIAINFO_Inform MediaInfo_Inform;
alias MEDIAINFOLIST_Inform = const(char)* function (void*, size_t, size_t Reserved);
extern __gshared MEDIAINFOLIST_Inform MediaInfoList_Inform;
alias MEDIAINFO_GetI = const(char)* function (void*, MediaInfo_stream_C StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
extern __gshared MEDIAINFO_GetI MediaInfo_GetI;
alias MEDIAINFOLIST_GetI = const(char)* function (void*, size_t, MediaInfo_stream_C StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
extern __gshared MEDIAINFOLIST_GetI MediaInfoList_GetI;
alias MEDIAINFO_Get = const(char)* function (void*, MediaInfo_stream_C StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
extern __gshared MEDIAINFO_Get MediaInfo_Get;
alias MEDIAINFOLIST_Get = const(char)* function (void*, size_t, MediaInfo_stream_C StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
extern __gshared MEDIAINFOLIST_Get MediaInfoList_Get;
alias MEDIAINFO_Output_Buffer_Get = c_ulong function (void*, const(MediaInfo_Char)* Parameter);
extern __gshared MEDIAINFO_Output_Buffer_Get MediaInfo_Output_Buffer_Get;
alias MEDIAINFO_Output_Buffer_GetI = c_ulong function (void*, size_t Pos);
extern __gshared MEDIAINFO_Output_Buffer_GetI MediaInfo_Output_Buffer_GetI;
alias MEDIAINFO_Option = const(char)* function (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
extern __gshared MEDIAINFO_Option MediaInfo_Option;
alias MEDIAINFOLIST_Option = const(char)* function (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
extern __gshared MEDIAINFOLIST_Option MediaInfoList_Option;
alias MEDIAINFO_State_Get = c_ulong function (void*);
extern __gshared MEDIAINFO_State_Get MediaInfo_State_Get;
alias MEDIAINFOLIST_State_Get = c_ulong function (void*);
extern __gshared MEDIAINFOLIST_State_Get MediaInfoList_State_Get;
alias MEDIAINFO_Count_Get = c_ulong function (void*, MediaInfo_stream_C StreamKind, size_t StreamNumber);
extern __gshared MEDIAINFO_Count_Get MediaInfo_Count_Get;
alias MEDIAINFOLIST_Count_Get = c_ulong function (void*, size_t, MediaInfo_stream_C StreamKind, size_t StreamNumber);
extern __gshared MEDIAINFOLIST_Count_Get MediaInfoList_Count_Get;
alias MEDIAINFO_Count_Get_Files = c_ulong function (void*);
extern __gshared MEDIAINFO_Count_Get_Files MediaInfo_Count_Get_Files;
alias MEDIAINFOLIST_Count_Get_Files = c_ulong function (void*);
extern __gshared MEDIAINFOLIST_Count_Get_Files MediaInfoList_Count_Get_Files;

/* Load library */

// get full app path and delete app name

/* MACOSX*/

/* Load methods */

// Unload DLL with errors
size_t MediaInfoDLL_Load ();

size_t MediaInfoDLL_IsLoaded ();

void MediaInfoDLL_UnLoad ();

/*__cplusplus*/

/***************************************************************************/
/***************************************************************************/
/***************************************************************************/

//DLL C++ wrapper for C functions

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
//MediaInfo_Char types

// Legacy
//Legacy

//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
/// @brief Kinds of Stream

///< StreamKind = General
///< StreamKind = Video
///< StreamKind = Audio
///< StreamKind = Text
///< StreamKind = Other
///< StreamKind = Image
///< StreamKind = Menu

/// @brief Kind of information

///< InfoKind = Unique name of parameter
///< InfoKind = Value of parameter
///< InfoKind = Unique name of measure unit of parameter
///< InfoKind = See infooptions_t
///< InfoKind = Translated name of parameter
///< InfoKind = Translated name of measure unit
///< InfoKind = More information about the parameter
///< InfoKind = Information : how data is found

/// Get(...)[infooptions_t] return a string like "YNYN..." \n
/// Use this enum to know at what correspond the Y (Yes) or N (No)
/// If Get(...)[0]==Y, then :
/// @brief Option if InfoKind = Info_Options

///< Show this parameter in Inform()
///<
///< Internal use only (info : Must be showed in Info_Capacities() )
///< Value return by a standard Get() can be : T (Text), I (Integer, warning up to 64 bits), F (Float), D (Date), B (Binary datas coded Base64) (Numbers are in Base 10)

/// @brief File opening options

///< Do not browse folders recursively
///< Close all files before open

//---------------------------------------------------------------------------

//File

//size_t Save () {MEDIAINFO_TEST_INT; return MediaInfo_Save(Handle);};

//General information

//size_t Set (const String &ToSet, stream_t StreamKind, size_t StreamNumber, size_t Parameter, const String &OldValue=__T(""))  {MEDIAINFO_TEST_INT; return MediaInfo_SetI (Handle, ToSet.c_str(), (MediaInfo_stream_C)StreamKind, StreamNumber, Parameter, OldValue.c_str());};
//size_t Set (const String &ToSet, stream_t StreamKind, size_t StreamNumber, const String &Parameter, const String &OldValue=__T(""))  {MEDIAINFO_TEST_INT; return MediaInfo_Set (Handle, ToSet.c_str(), (MediaInfo_stream_C)StreamKind, StreamNumber, Parameter.c_str(), OldValue.c_str());};

//File

//size_t Save (size_t FilePos) {MEDIAINFO_TEST_INT; return MediaInfoList_Save(Handle, FilePos);};

//General information

//size_t Set (const String &ToSet, size_t FilePos, stream_t StreamKind, size_t StreamNumber, size_t Parameter, const String &OldValue=__T(""))  {MEDIAINFO_TEST_INT; return MediaInfoList_SetI (Handle, ToSet.c_str(), FilePos, (MediaInfo_stream_C)StreamKind, StreamNumber, Parameter, OldValue.c_str());};
//size_t Set (const String &ToSet, size_t FilePos, stream_t StreamKind, size_t StreamNumber, const String &Parameter, const String &OldValue=__T(""))  {MEDIAINFO_TEST_INT; return MediaInfoList_Set (Handle, ToSet.c_str(), FilePos, (MediaInfo_stream_C)StreamKind, StreamNumber, Parameter.c_str(), OldValue.c_str());};

//NameSpace
/*__cplusplus*/

