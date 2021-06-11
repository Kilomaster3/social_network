# README

How do I launch the app?

Dependencies:
- ruby (v. 2.7.1)
- rails (v. 6.0.3)



To launch the app:

1. open the console in the project directory and write "bundle exec rails s".
2. check localhost: 3000 in your browser



The most difficult task:

While I was developing this project, the most difficult of them was working with the GoogleMap service so that users with an intersection of the selected interests could find themselves on the map. At the moment, I certainly think it's not that difficult, but at the time I spent a lot of effort on it. I spent a lot of time to properly link everything between the database and the Js code for the correct display.

The most interesting task:

To be honest, I can't single out any specific task due to the large number of requirements, many of them seemed useful and interesting to me, among them such as: working with the "devise" gem, using the "cable_ready" gem, using "gon" to sub-load data more quickly into Js code, creating a job to send notifications via the" sidekiq " gem, internationalization in rails, and much, much more.


What could I do if I had more time?

First, I would add more tools in admin mode and implement a mobile version of the site.
Also, I think I would optimize the backend logic to speed up the project.
