[![Build Status](https://travis-ci.org/andriyErmoshyn/adverts_app.svg)](https://travis-ci.org/andriyErmoshyn/adverts_app)

# The Adverts application

[yermoshin-ads.herokuapp.com](https://yermoshin-ads.herokuapp.com)


The application created as a test task.

## App description

* Members system:
  - new member registration;
  - profile items: login, full name, birthday, e-mail, address, city, state, country, zip, password, password confirmation (all fields are obligatory);
  - member's location automatic determination after filling in form fields (address, city, state, zip, country), displaying it on the map (on sign up and edit profile pages);
  - updating member's profile;
  - password reset;
  - member's profile can be seen by any user;
  - logging in with Facebook and Twitter;

* Ads system
  - creating/updating/deleting ads by logged in members;
  - adding/updating comments to ads;
  - ad fields: author, text, picture;
  - using Textile markup for ads;
  - adding/deleting comment with AJAX;
  - only Admin, Moderator or author can destroy the comment;
  - unauthorized user can see ads and member's profile;
  - the ads list shows thumbnail, author and truncated ad text (if more than 160 symbols);
  - searching ads by author, address, content;

* Roles system:
  - managing roles with CanCanCan;
  - 3 roles: admin, moderator, user;
  - *Admin:* 
    - can be created in heroku console(member.update_attribute(:role, 3));
    - manages members, sets roles;
  - *Moderator:* manages ads and comments;
  - *User:* manages his own ads and comments;

* Pages:
  - the main page includes ads list;
  - authorized member can see member's, own profile's and ads' links, log out link;
  - show ad;
  - authorization;
  - registration;
  - profile;

  * Tests:
   - Rspec, Capybara, Faker;
   - simplecov(91.32%);
   - travis ci.
