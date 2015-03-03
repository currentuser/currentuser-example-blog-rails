# currentuser-example-blog-rails
Example Rails application using [Currentuser.io](http://www.currentuser.io).

This application uses MySQL for demo purpose but we could have use PostgreSQL.

## How this application has been built?

_**Note: this part of the documentation explains how the source code of this application has been built for educational purpose.
You don't need to follow these steps if you only want to run the application.**_

The source code of this application has been built the following way:
```sh
rails new currentuser-example-blog-rails --database=mysql
```
The file `config/database.yml` has been adapted to make database configuration more flexible.

## Deployment

To retrieve a local version of this application:
```sh
git clone https://github.com/currentuser/currentuser-example-blog-rails.git
```

### Remote

TBD

### Local

Create a MySQL user (you could skip this part if you prefer to use your `root` user):
```sql
CREATE USER 'cu_ex_blog_rails'@'localhost' IDENTIFIED BY 'cu_ex_blog_rails';
GRANT ALL ON cu_ex_blog_rails.* TO 'cu_ex_blog_rails'@'localhost';
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
