# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment and startup programs

# Add omablue scripts to PATH
export PATH="$HOME/.local/share/omablue/bin:$PATH"
