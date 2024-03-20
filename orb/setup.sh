#/bin/bash

# Check orbstack environment
kernel_name=$(uname -r)
if [[ $kernel_name != *"orbstack"* ]]; then
  echo "orbstack not found in the kernel name. Exiting..."
  exit 1
fi

# Update and install packages
sudo apt-get update

sudo apt-get install -y zsh
sudo apt-get install -y git
sudo apt-get install -y vim
sudo apt-get install -y neovim
sudo apt-get install -y iputils-ping
sudo apt-get install -y dnsutils
sudo apt-get install -y bat
sudo apt-get install -y htop
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt-get install -y build-essential
sudo apt-get install -y gnupg
sudo apt-get install -y zip
sudo apt-get install -y unzip
sudo apt-get install -y tree
sudo apt-get install -y neofetch
sudo apt-get install -y fzf
sudo apt-get install -y ripgrep

# Install oh-my-zsh
sudo chsh -s $(which zsh) brian
yes | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add wezterm source and install
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update
sudo apt install wezterm -y

# Install pyenv
curl https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
zsh -c "source ~/.zshrc && pyenv install 3.11"

# Install nexttrace
curl nxtrace.org/nt | sudo bash

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
echo "source $HOME/.cargo/env" >> ~/.zshrc

# Install starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y
mkdir -p /home/brian/.config && wget https://raw.githubusercontent.com/xxxbrian/dot/main/config/starship.toml -O /home/brian/.config/starship.toml
echo -e "[container]\nformat = '[\$symbol Orbstack](\$style) '\n" >> /home/brian/.config/starship.toml
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Setup fzf
echo 'eval "$(fzf --zsh)"' >> ~/.zshrc
echo 'export FZF_DEFAULT_COMMAND="rg --files --hidden"' >> ~/.zshrc

# Finish message
curl -s https://raw.githubusercontent.com/xxxbrian/dot/main/orb/img/orbstack-name.png | wezterm imgcat && echo "VM Setup Complete!"
