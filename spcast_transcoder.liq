#!/home/spcast/.opam/default/bin/liquidsoap

# Log: https://www.liquidsoap.info/doc-dev/settings.html#log-configuration
settings.log.unix_timestamps.set(true)
settings.log.stdout.set(true)
settings.log.level.set(3)
settings.log.file.set(true)
settings.log.file.perms.set(384)
settings.log.file.path.set("/home/spcast/SPCast/transcoder/logs/transcoder.log")
settings.log.file.append.set(true)

# Daemon: https://www.liquidsoap.info/doc-dev/settings.html#run-in-daemon-mode
settings.init.daemon.set(true)
settings.init.daemon.pidfile.set(true)
settings.init.daemon.pidfile.perms.set(416)
settings.init.daemon.pidfile.path.set("/home/spcast/SPCast/transcoder/spcast_transcoder.pid")
settings.init.daemon.change_user.set(true)
settings.init.daemon.change_user.user.set("spcast")
settings.init.daemon.change_user.group.set("spcast")

# Harbor: https://www.liquidsoap.info/doc-dev/settings.html#harbor-settings-icecastshoutcast-stream-receiver.
settings.harbor.verbose.set(true)
settings.harbor.timeout.set(300.)
settings.harbor.reverse_dns.set(false)
settings.harbor.max_connections.set(2)
settings.harbor.icy_formats.set(["audio/mpeg", "audio/aacp", "audio/aac", "audio/x-aac", "audio/wav", "audio/wave", "audio/flac", "audio/x-flac"])
settings.harbor.bind_addrs.set(["127.0.0.1"])

# Frame Format: https://www.liquidsoap.info/doc-dev/settings.html#frame-format
settings.frame.midi.channels.set(0)
settings.frame.duration.set(0.01)
#settings.frame.audio.size.set(<value>)
#settings.frame.audio.samplerate.set(44100)
#settings.frame.audio.channels.set(2)

# We dont have video outputs here
settings.frame.video.samplerate.set(0)

# Metadata: https://www.liquidsoap.info/doc-dev/settings.html#encoder-settings
settings.encoder.metadata.export.set(["artist", "title", "album", "genre", "date", "tracknumber", "comment", "track", "year", "dj", "next", "apic", "metadata_block_picture", "coverart"])

# Clock: https://www.liquidsoap.info/doc-dev/settings.html#streaming-clock-settings
settings.root.max_latency.set(60.)

# remote source to be transcoded
remoteUrl = "http://localhost:80/stream"

# Get the remote stream and set a user agent. 
# Then, add a buffer to handle any network inconsistencies.
relay = buffer(mksafe(input.http(remoteUrl, user_agent="SPCast Transcoder")))

# Convert the stream to stereo
#convertstereo = audio_to_stereo(relay)

# local emergency file
emergency = single("/home/spcast/SPCast/transcoder/offline_transcoder.mp3")

# Use a fallback mechanism. 
# If the remote stream goes offline or is unavailable, 
# it will automatically switch to the emergency file.
#radio = fallback(track_sensitive=false, [convertstereo, emergency])
radio = fallback(track_sensitive=false, [relay, emergency])

# Include Radio details and Credentials
%include "transcoder_radiodata.liq"
%include "transcoder_credentials.liq"

# If you want to output the transcoded stream to an Icecast server, 
# you'll include appropriate output.icecast lines in the "transcoder_credentials.liq" file.

