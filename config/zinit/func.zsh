
### Custom Functions

# git last commit date edit
function git-amend-date() {
  local date=$1
  GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit --amend --no-edit --date="$date" --no-verify
}

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# dog (doggo with surge)
DOG_SURGE_DNS="198.18.0.2"
DOG_DEFAULT_DNS="https://dns.alidns.com/dns-query"
function dog() {
    # Check if has spec dns server
    if [[ "$@" == *@* ]]; then
        doggo "$@"
    else
        # Get systen DNS from /etc/resolv.conf
        current_dns=$(cat /etc/resolv.conf | grep '^nameserver' | awk '{print $2}' | head -n 1)
        # Not Surge DNS
        if [ "$current_dns" != "$DOG_SURGE_DNS" ]; then
            doggo "$@"
        else
            # Is Surge DNS, use dog default dns
            doggo "$@" @"$DOG_DEFAULT_DNS"
        fi
    fi
}

# check if using correct cargo
function check_cargo() {
  cargo_path=$(which cargo 2>/dev/null)
  if [[ -z "$cargo_path" ]]; then
    echo "Cargo is not installed or not in PATH."
    return 1
  fi
  if [[ "$cargo_path" == "/opt/homebrew/bin/cargo" ]]; then
    echo "$cargo_path cargo path error"
  fi
}

# list all node_modules
function list_node_modules() {
  fd node_modules --type d --absolute-path | rg -v '/node_modules/.*/node_modules' | xargs -I {} du -sh {}
}
