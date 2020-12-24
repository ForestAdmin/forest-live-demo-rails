# Forest Live Demo - Ruby on Rails 5

This is the official open-source code of the Forest Live Demo on Rails 5.

Works well with ruby 2.3.8 or 2.4.9

### Install dependencies
```shell script
$> sudo gem install bundler:2.2.0
$> bundle update --bundler
$> bundle install
```

### Launch server

```shell script
$> FOREST_URL=https://api.development.forestadmin.com rails server -b 0.0.0.0 -p 3000 -e development"
```