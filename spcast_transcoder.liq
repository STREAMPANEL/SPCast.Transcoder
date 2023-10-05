#!/home/spcast/.opam/default/bin/liquidsoap

# Log Configuration
settings.log.unix_timestamps.set(true) # Use UNIX timestamps in logs
settings.log.stdout.set(true) # Log to stdout
settings.log.level.set(3) # Set log level: 3 is "info"
settings.log.file.set(true) # Enable logging to a file
settings.log.file.perms.set(384) # File permissions for the log file
settings.log.file.path.set("/home/spcast/SPCast/transcoder/logs/transcoder.log") # Path to the log file
settings.log.file.append.set(true) # Append to the log file (instead of overwriting)

# Daemon Configuration
settings.init.daemon.set(true) # Run as a daemon
settings.init.daemon.pidfile.set(true) # Use a PID file
settings.init.daemon.pidfile.perms.set(416) # Set PID file permissions
settings.init.daemon.pidfile.path.set("/home/spcast/SPCast/transcoder/spcast_transcoder.pid") # PID file path
settings.init.daemon.change_user.set(true) # Change user/group when running as daemon
settings.init.daemon.change_user.user.set("spcast") # User to switch to
settings.init.daemon.change_user.group.set("spcast") # Group to switch to

# Harbor Configuration (stream receiver settings)
settings.harbor.verbose.set(true)            
settings.harbor.timeout.set(300.) # Set a timeout for harbor connections
settings.harbor.reverse_dns.set(false) # Disable reverse DNS lookup
settings.harbor.max_connections.set(2) # Set max simultaneous connections to the harbor
settings.harbor.icy_formats.set(["audio/mpeg", "audio/aacp", "audio/aac", "audio/x-aac", "audio/wav", "audio/wave", "audio/flac", "audio/x-flac"])
settings.harbor.bind_addrs.set(["127.0.0.1"]) # IPs to bind the harbor to

# Frame Format Configuration
settings.frame.midi.channels.set(0) # Disable MIDI channels
settings.frame.duration.set(0.01) # Set frame duration
settings.frame.audio.samplerate.set(44100) # Set the audio sample rate for the frame
settings.frame.audio.channels.set(2) # Set the number of audio channels for the frame (2 for stereo)

# Metadata Configuration for Encoders
settings.encoder.metadata.export.set(["artist", "title", "album", "genre", "date", "tracknumber", "comment", "track", "year", "dj", "next", "apic", "metadata_block_picture", "coverart"])

# Audio settings
settings.audio.converter.samplerate.native.quality.set("nearest") # either “nearest” or default “linear”
settings.audio.converter.samplerate.libsamplerate.quality.set("zero_order") # "best", "medium", "fast", "zero_order" or "linear"
settings.audio.converter.samplerate.converters.set(["native"]) # "libsamplerate", "ffmpeg", "native"

# Video settings
settings.video.converter.preferred.set("none") # default is ffmpeg
settings.video.converter.proportional_scale.set(false) # Preferred proportional scale

# Clock Configuration
settings.root.max_latency.set(5.) # Set max latency for the root clock

# Define remote source URL
remoteUrl = "http://localhost:80/stream"

# Fetch the remote stream with a custom user agent
relay = buffer(mksafe(input.http(remoteUrl, user_agent="SPCast Transcoder")))

# Local fallback (emergency) file
emergency = single("/home/spcast/SPCast/transcoder/offline_transcoder.mp3")

# Fallback mechanism: switch to emergency file if the relay stream is down
radio = fallback(track_sensitive=false, [relay, emergency])

# Include external files for radio details and authentication credentials
%include "transcoder_radiodata.liq"
%include "transcoder_credentials.liq"
