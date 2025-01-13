export TERMINAL=/usr/bin/alacritty

export XDG_CONFIG_HOME=$HOME/.local/config/
export XDG_DATA_HOME=$HOME/.local/share/
export XDG_STATE_HOME=$HOME/.local/state/
export XDG_CACHE_HOME=$HOME/.local/cache/

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export SSB_HOME="$XDG_DATA_HOME"/zoom
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java - Djavafx.cachedir=${XDG_CACHE_HOME}/openjfx"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

