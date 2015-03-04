# currentuser-example-blog-rails
Example Rails application using [Currentuser.io](http://www.currentuser.io).

This application uses MySQL for demo purpose because it is widely used, but Currentuser.io works great with PostgreSQL too.

## How this application has been built?

_**Note: this part of the documentation explains how the source code of this application has been built for educational purpose.
You don't need to follow these steps if you only want to run the application.**_

**1.** The base of the application has been generated with Rails:

```sh
rails new currentuser-example-blog-rails --database=mysql
```

**2.** The file [Gemfile](Gemfile) has been enhanced with the following gems:

* [activeuuid](https://github.com/jashmenn/activeuuid) allows optimized uuid with MySQL (not required if we had used PostgreSQL)
* [rails_12factor](https://github.com/heroku/rails_12factor) allows easier deployment on Heroku
* [figaro](https://github.com/laserlemon/figaro) allows easier local deployment

**3.** [currentuser-services](https://github.com/currentuser/currentuser-services-gem) gem has been installed and configured,
as explained in the [documentation](http://www.currentuser.io/documentation/resources.html):

```ruby
# Gemfile
gem 'currentuser-services'
```

```ruby
# config/routes.rb
MyApplication::Application.routes.draw do
  currentuser
end
```

```ruby
# config/initializers/currentuser.rb
Currentuser::Services.configure do |config|
  config.project_id = ENV['CURRENTUSER_PROJECT_ID']
end
```

**4.** The file [config/database.yml](config/database.yml) has been adapted to make database configuration more flexible.

**5.** The base of the behavior has been generated with a Rails scaffold:

```sh
rails generate scaffold Post user_id:uuid:index body:text
```

**6.** The PostsController has been protected, as explained in the [documentation](http://www.currentuser.io/documentation/authentication.html):

```ruby
# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  before_action :require_currentuser
```

**6.** A root route has been added:

```ruby
# config/routes.rb
Rails.application.routes.draw do
  root 'posts#index'
```

## Deployment

To retrieve a local version of this application:
```sh
git clone https://github.com/currentuser/currentuser-example-blog-rails.git
```

### Remote

#### Heroku

**1.** Create an application on heroku.com.

**2.** Configure your git repository (replace `xxx` by the name of your application) and deploy it:
```sh
heroku git:remote -a xxx
git push heroku
```

**3.** Create an application on [Currentuser.io](http://www.currentuser.io) (use `https://xxx.herokuapp.com` as application URL)
and retrieve Project ID from the Currentuser.io settings.

**4.** Configure your application (replace 'ffffffff-ffff-ffff-ffff-ffffffffffff' with your Currentuser.io Project ID)

```sh
heroku config:set CURRENTUSER_PROJECT_ID=ffffffff-ffff-ffff-ffff-ffffffffffff
```

**5.** Provision and configure ClearDB plugin: https://devcenter.heroku.com/articles/cleardb

**6.** Initialize your database:
```sh
heroku run rake db:schema:load
```

#### Other platforms

See your platform documentation.

### Local

**1.** Install the gems

```sh
bundle
```

**2.** Create a MySQL user (you could skip this part if you prefer to use your `root` user):

```sql
CREATE USER cu_ex_blog_rails@localhost IDENTIFIED BY 'cu_ex_blog_rails';
GRANT ALL ON cu_ex_blog_rails.* TO cu_ex_blog_rails@localhost;
```

**3.** Create an application on [Currentuser.io](http://www.currentuser.io) (use `http://localhost:3000` as application URL)
and retrieve Project ID from the Currentuser.io settings.

**4.** Create a configuration file:

```yaml
# config/application.yml

DATABASE_URL: mysql2://cu_ex_blog_rails:cu_ex_blog_rails@localhost/cu_ex_blog_rails

# Replace 'ffffffff-ffff-ffff-ffff-ffffffffffff' with your Currentuser.io Project ID
CURRENTUSER_PROJECT_ID: ffffffff-ffff-ffff-ffff-ffffffffffff
```

**5.** Initialize your database:

```sh
rake db:setup
```
