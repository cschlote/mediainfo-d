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

/*Char types                                                               */
alias MediaInfo_Char = char;

/*8-bit int                                                                */
alias MediaInfo_int8u = ubyte;

/*64-bit int                                                               */
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

/** @brief File opening options */
enum MediaInfo_fileoptions_t
{
    MediaInfo_FileOption_Nothing = 0x00,
    MediaInfo_FileOption_NoRecursive = 0x01,
    MediaInfo_FileOption_CloseAll = 0x02,
    MediaInfo_FileOption_Max = 0x04
}

version(MediaInfo_utf16) {
    extern __gshared void* MediaInfo_New();
    extern __gshared void* MediaInfoList_New();
    extern __gshared void MediaInfo_Delete (void*);
    extern __gshared void MediaInfoList_Delete (void*);
    extern __gshared c_ulong MediaInfo_Open (void*, const(MediaInfo_Char)*);
    extern __gshared c_ulong MediaInfoList_Open (void*, const(MediaInfo_Char)*, const MediaInfo_fileoptions_t);
    extern __gshared c_ulong  MediaInfo_Open_Buffer_Init (void*, MediaInfo_int64u File_Size, MediaInfo_int64u File_Offset);
    extern __gshared c_ulong MediaInfo_Open_Buffer_Continue (void*, MediaInfo_int8u* Buffer, size_t Buffer_Size);
    extern __gshared ulong MediaInfo_Open_Buffer_Continue_GoTo_Get (void*);
    extern __gshared c_ulong MediaInfo_Open_Buffer_Finalize (void*);
    extern __gshared c_ulong MediaInfo_Open_NextPacket (void*);
    extern __gshared void MediaInfo_Close (void*);
    extern __gshared void MediaInfoList_Close (void*, size_t);
    extern __gshared const(char)* MediaInfo_Inform (void*, size_t Reserved);
    extern __gshared const(char)* MediaInfoList_Inform (void*, size_t, size_t Reserved);
    extern __gshared const(char)* MediaInfo_GetI (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
    extern __gshared const(char)* MediaInfoList_GetI (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
    extern __gshared const(char)* MediaInfo_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
    extern __gshared const(char)* MediaInfoList_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
    extern __gshared c_ulong MediaInfo_Output_Buffer_Get (void*, const(MediaInfo_Char)* Parameter);
    extern __gshared c_ulong MediaInfo_Output_Buffer_GetI (void*, size_t Pos);
    extern __gshared const(char)* MediaInfo_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared const(char)* MediaInfoList_Option (void*, const(MediaInfo_Char)* Parameter, const(MediaInfo_Char)* Value);
    extern __gshared c_ulong MediaInfo_State_Get (void*);
    extern __gshared c_ulong MediaInfoList_State_Get (void*);
    extern __gshared c_ulong MediaInfo_Count_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfoList_Count_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber);
    extern __gshared c_ulong MediaInfo_Count_Get_Files (void*);
    extern __gshared c_ulong MediaInfoList_Count_Get_Files (void*);
}

/* ASCII und UTF-8 Functions */
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
extern __gshared const(char)* MediaInfoA_GetI (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
extern __gshared const(char)* MediaInfoListA_GetI (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, size_t Parameter, MediaInfo_info_C KindOfInfo);
extern __gshared const(char)* MediaInfoA_Get (void*, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
extern __gshared const(char)* MediaInfoListA_Get (void*, size_t, MediaInfo_stream_t StreamKind, size_t StreamNumber, const(MediaInfo_Char)* Parameter, MediaInfo_info_C KindOfInfo, MediaInfo_info_C KindOfSearch);
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

