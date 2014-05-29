# Review Site: a basic user-submitted review site on Rails

This is a review site. It includes the following features/design elements (so far):

* An authentication and authorization system based on [Mike Hartl's Rails Tutorial](http://www.railstutorial.org/) (so, no Devise or other authentication gems)
* Likewise, a static pages controller also based on the Hartl tutorial
* Password resets via email, influenced closely by the [RailsCast on the subject](http://railscasts.com/episodes/274-remember-me-reset-password)
* A separate Profile model linked in a has_one relationship to User
* Tested with RSpec using [Capybara](https://github.com/jnicklas/capybara) and [FactoryGirl](https://github.com/thoughtbot/factory_girl)
* Mocked out with (Bootstrap)[http://www.getbootstrap.com]