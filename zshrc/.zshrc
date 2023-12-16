# Created by newuser for 5.9


# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/rijan/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# sourcing plugins

source /home/rijan/community_repos/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh


# bun completions
[ -s "/home/rijan/.bun/_bun" ] && source "/home/rijan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export EDITOR=helix

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/rijan/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/rijan/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/rijan/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/rijan/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/rijan/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/rijan/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

function gitup() {
	git add .
	git commit -a -m "$1"
	git push
}

uahvpn(){
	sudo openconnect --protocol=nc -C "DSID="$1 psvpn.uah.edu
}

function newterim() {
  mkdir -p "$1/blackbox"
  mkdir -p "$1/input"
  mkdir -p "$1/output"
  touch "$1/README.md"
}

compress_directory() {
    # Default compression level
    local COMP_LEVEL=6

    # Parse options
    while getopts ":l:" opt; do
        case ${opt} in
            l)
                COMP_LEVEL=$OPTARG
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                return 1
                ;;
            :)
                echo "Option -$OPTARG requires an argument." >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND -1))

    # Check if an argument is provided
    if [ $# -ne 1 ]; then
        echo "Usage: compress_directory [-l level] <directory>"
        return 1
    fi

    # Get the directory name from the argument
    local SOURCE_DIR="$1"

    # Extract the basename of the directory
    local BASENAME=$(basename "$SOURCE_DIR")

    # Create a tar archive of the directory
    tar -cvf - "$SOURCE_DIR" | zstd -$COMP_LEVEL -o "$BASENAME.tar.zst"

    echo "Compressed archive saved as $BASENAME.tar.zst"
}

