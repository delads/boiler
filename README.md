# README

## Set up configuration files

On the root directory, create a `Gemfile` to load your dependencies

```
source 'https://rubygems.org'
gem 'sinatra'
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'pg'
gem 'rake'
```


Create `config.ru`. This configuration file is needed for runtime and loads the dependencies needed (especially `activerecord` needed for connecting to the database. 
```
require 'sinatra'
require 'sinatra/activerecord'
require './server'


run Sinatra::Application
```


Create `Rakefile` to load dependencies for creating and running database migrations
```
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'
```

Create `database.yml` in a folder called `config`
```
development:
  adapter: postgresql
  encoding: unicode
  database: test_boiler_db_3
  pool: 2
```

## Server files

Create `server.rb` on the root directory. Require each Model class as necessary
```
require './models/record'

get '/' do
  erb :index
end

get '/record' do
  @records = Record.all
  erb :record
end

get '/addrecord' do
  Record.create(name: params[:name])
  redirect '/record'
end
```

Create `index.erb` inside a `views` folder
```
<% @records %>
 <% @records.each do |record| %>
    Hello <%= record.name %>
    <br>
<% end %>
```

## Create database migrations and Models

In terminal 
```
rake db:create_migration NAME=create_records
```

Modify the migration file `xxx_yyy_zzz_create_record.rb`
```
class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.text     :name
      t.timestamps
    end
  end
end
```

In terminal
```
rake db:create
rake db:migrate
```

Create `record.rb` in a folder `models`
```
class Record < ActiveRecord::Base
  
end
```

## Deploy locally

In terminal
```
bundle install
rackup
```

## Add to git
In terminal
```
git init
git add -A
git commit -m "Initial Commit"
```

## Commit to Github
Log into www.github.com and create a new repository
Copy the https:// repo location to clipboard and open terminal
```
git remote add origin https://github.com/delads/new_repo.git
git remote

```

## Deploy to Heroku
Open terminal
```
heroku create
git push heroku master
heroku rake db:migrate
```

Boom!











