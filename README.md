# RL Process

This is the README of this project, we try to keep ruby and rails on HEAD

* Ruby 2.5.3

* Rails 5.2.2.1

* Postgres


## Installation on Mac

### Homebew

First install xcode and its dependencies

After that

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Validate installation with

```
brew doctor
```

### RVM

To install RVM

```
curl -sSL https://get.rvm.io | bash
```

If you use fish

```
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish

echo "rvm default" >> ~/.config/fish/config.fish
```

### Ruby

To install ruby

```
rvm install ruby 2.5.2
```

### Postgres

To install postgres with homebrew just run

```
brew uninstall --force postgresql

rm -rf /usr/local/var/postgres

brew install postgres
```

### NVM and Yarn

We use NVM to manage node versions and yarn to manage project packages

To install nvm

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```

For fish

```
omf install https://github.com/FabioAntunes/fish-nvm
omf install https://github.com/edc/bass
```

And to Install yarn

```
brew install yarn --without-node
```


## Running the project

Last but no least, lets run the project

```
cp config/database.yml.example config/database.yml
```

And edit the files to correspond to your configurations

```
rake db:create
rake db:migrate
```

Run yarn

```
yarn install
```

install foreman

```
gem install foreman
```

and finally run the project with

```
foreman start -f Procfile.dev
```
