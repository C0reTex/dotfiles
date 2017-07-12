class Py3status:
    shorten = True
    playing_format = ""
    paused_format = ""
    format_prefix = u": "
    format = "{prefix} {artist} {status} {title}"

    def Spotify(self):
        import os
        command_artist = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A2 \"xesam:artist\" | tail -n 1 | sed -e 's/.*string \|\"//g' "
        command_title = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -A2 \"xesam:title\" | awk '{v[c++]=$0}END{print v[c-2]}' | sed -e 's/.*variant.*string \|\"//g' "
        command_PlaybackStatus = "dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | tail -n 1 | sed -e 's/.*variant.*string \|\"//g'"

        status = os.popen(command_PlaybackStatus).read()
        status = status.rstrip()
        if (status == "Playing"):
            status = self.playing_format
        else:
            status = self.paused_format

        artist = os.popen(command_artist).read()
        artist = artist.rstrip()
        title = os.popen(command_title).read()
        title = title.rstrip()
        #format = artist.rstrip() + " " + status + "  " + title.rstrip()

        full_text = self.py3.safe_format(self.format,
                {
                    'prefix': self.format_prefix,
                    'artist': artist,
                    'status': status,
                    'title' : title
                    })
        print(full_text)
        return {
            'full_text': full_text,
            'color': "#2ebd59",
            'cached_until': self.py3.time_in(1)
                }
