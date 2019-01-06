module main;

import std.conv;
import std.stdio;

import mediainfodll;
import mediainfo;


int main(string[] args)
{
    if (args.length < 2)
        return 1;
    auto info = MediaInfo();
    string vstring = info.option("Info_Version", "0.7.38.0;DTest;0.1");
    writefln("Found version %s", vstring);
    if (vstring == "")
        throw new Exception("Incompatible mediainfo version");

    info.option("Internet", "No");

    info.open(args[1]);
    scope (exit)
    {
        info.close();
    }

    ulong nVideo = info.getCount(MediaInfo_stream_t.MediaInfo_Stream_Video);
    ulong nAudio = info.getCount(MediaInfo_stream_t.MediaInfo_Stream_Audio);
    ulong nText = info.getCount(MediaInfo_stream_t.MediaInfo_Stream_Text);

    if (nText == 0 && nVideo == 0 && nAudio == 0)
        return 0;

    writefln("---%s---", info.get(MediaInfo_stream_t.MediaInfo_Stream_General, 0, "FileName"));
    for (uint i = 0; i < nVideo; i++)
    {
        writefln("Video track %s:", i);
        writefln("  Resolution: %s x %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i,
                "Width"), info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i, "Height"));
        writefln("  FPS: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i, "FrameRate"));
        writefln("  Duration: %s",
                info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i, "Duration/String"));
        string brate = info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i, "BitRate");
        if (brate != "")
            writefln("  Bitrate: %s kbps", to!long(brate) / 1024);
        writefln("  Format: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Video, i, "Format"));
    }

    for (uint i = 0; i < nAudio; i++)
    {
        writefln("Audio track %s:", i);
        std.stdio.writef("  Channels: %s",
                info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "Channel(s)"));
        string cpos = info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "ChannelPositions");
        if (cpos != "")
            writefln(" (%s)", cpos);
        else
            writeln();
        writefln("  Duration: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "Duration/String"));
        string brate = info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "BitRate");
        if (brate != "")
        {
            writefln("  Bitrate: %s kbps (%s)", to!long(brate) / 1024,
                    info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "BitRate_Mode"));
        }
        writefln("  Format: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Audio, i, "Format"));
    }

    for (uint i = 0; i < nText; i++)
    {
        writefln("Text track %s:", i);
        writefln("  Language: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Text, i, "Language"));
        writefln("  FPS: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Text, i, "FrameRate"));
        writefln("  Duration: %s",
                info.get(MediaInfo_stream_t.MediaInfo_Stream_Text, i, "Duration/String"));
        string brate = info.get(MediaInfo_stream_t.MediaInfo_Stream_Text, i, "BitRate");
        if (brate != "")
            writefln("  Bitrate: %s kbps", to!long(brate) / 1024);
        writefln("  Format: %s", info.get(MediaInfo_stream_t.MediaInfo_Stream_Text, i, "Format"));
    }
    return 0;
}
