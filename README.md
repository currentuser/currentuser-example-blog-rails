# currentuser-example-blog-rails
Example Rails application using [Currentuser.io](http://www.currentuser.io).

This application uses MySQL for demo purpose because it is widely used, but Currentuser.io works great with PostgreSQL too.

## How this application has been built?

_**Note: this part of the documentation explains how the source code of this application has been built for educational purpose.
You don't need to follow these steps if you only want to run the application.**_

The source code of this application has been built the following way:
```sh
rails new currentuser-example-blog-rails --database=mysql
rails generate scaffold Post user_id:uuid:index body:text
```
The file `config/database.yml` has been adapted to make database configuration more flexible.

The file `Gemfile` has been enhanced with the following gems:

* `activeuuid` allows optimized uuid with MySQL (not required if we had used PostgreSQL)
* `rails_12factor` allows easier deployment on Heroku
* `figaro` allows to write ENV variables in a file `config/application.yml`

Note that none of these gems is strictly required for Currentuser.io.

## Deployment

To retrieve a local version of this application:
```sh
git clone https://github.com/currentuser/currentuser-example-blog-rails.git
```

### Remote

#### Heroku

**1.** Create an application on heroku.com.

**2.** Provision and configure ClearDB plugin: https://devcenter.heroku.com/articles/cleardb

**3.** Configure your git repository (replace `xxx` by the name of your application) and deploy it:
```sh
heroku git:remote -a xxx
git push heroku
```

**4.** Initialize your database:
```sh
heroku run rake db:schema:load
```

#### Other platforms

See your platform documentation.

### Local

Create a MySQL user (you could skip this part if you prefer to use your `root` user):
```sql
CREATE USER cu_ex_blog_rails@localhost IDENTIFIED BY 'cu_ex_blog_rails';
GRANT ALL ON cu_ex_blog_rails.* TO cu_ex_blog_rails@localhost;
```
Create a configuration file:
```yaml
# config/application.yml
DATABASE_URL: mysql2://cu_ex_blog_rails:cu_ex_blog_rails@localhost/cu_ex_blog_rails
```
Install the gems and initialize database:
```sh
bundle
rake db:setup
```
