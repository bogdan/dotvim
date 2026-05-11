ln -s ~/.vim/vimrc ~/.vimrc
mkdir -p ~/.config && ln -s ~/.vim ~/.config/nvim
git clone https://github.com/folke/lazy.nvim.git ~/.vim/lua/lazy/lazy.nvim --filter=blob:none --branch=stable
