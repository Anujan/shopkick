#Shopkick

Hey there! Shopkick is a eCommerce website I made to test my skills in Rails and JavaScript. It allows users to sign up and create their own online store. 

Please visit the live [demo](http://shopkick.co). You can either sign up or use the demo login button provided.

## Technologies Used

* CRUD
* Basic Forms
* User Authentication
* ActionMailer (Sendgrid)
* Partials/helpers
* Routing
* File Upload (with Paperclip)
* JavaScript 
* jQuery
* Backbone.js
* Postgres
* Heroku Deployment
* Multi-tenancy with PostgreSQL schemas
* Subdomains
* SMS Notifications (with Twilio)
* Payment processing (Stripe)
* Background Jobs (Sidekiq)

## Neat Features

###Multitenancy
I had two ways to approach this problem. The first way was to use ActiveRecord scopes to scope all store information to the store's ID. The approach that I ended up taking was using PostgreSQL's schemas. 

In Postgres, a database cluster has one or more named schemas. By default, you only have a "public" and a "$user" schema. The public one is the one that Rails uses at first. I used the [Apartment][apartment] gem to achieve this, and had the database switch to the subdomain name. 

So upon creating a store, we create a database for you as well. That database stores all the store's information such as products, orders, etc. This information isn't accessible by any other store. So whenever there is a subdomain, we switch the schema to the subdomain's name and it scopes everything to the current store.


### Background Jobs
All order processing is done with a background job. I used Sidekiq and Redis to achieve this. I had previously used DelayedJob but it has some conflicting issues with the way my database schemas work due to the multitenancy. 

Charging orders (with Stripe), sending notifications through email (SendGrid) and SMS (Twilio) are all done with background jobs so they don't slow down requests. Image uploading is also done through a background job because it can delay the request a very suboptimal amount of time due to all the images we generate and upload to AWS between the request.

### Backbone.JS and UJS
I built the whole admin interface in BackboneJS. It allows you to view, edit and save any of the models. 

I also created a small plugin for the searching so I could reuse the same view each time rather than pasting the code multiple times. The plugin allows you to pass in a collection, and attributs to search against. It then creates a input field on the page and returns a filtered collection based on the value of the input field. The file can be viewed [here][input-plugin].

I also had to extend the default Backbone router because I wanted to add a few features. The main reason for extending the router was to add a before filter to it. I wanted to destroy all the event listeners on the current view so it can be garbage collected. I then loaded the collection that the new view is going to use. Once that is done, I render the new view and set it to being the currentView. The file can be viewed [here][router-mixin].

Since I only used Backbone for the admin interface, I ended up using UJS to ajaxify my store's frontend. I had a few reasons to not use Backbone, the main reason being was that I wanted to eventually implement templating. By using UJS, I allow the user to have more freedom with their template since Backbone wouldn't be doing any DOM manipulation. I also made my UJS use pushState (History API) to change the URL upon being called. This also allowed me to create infinite scrolling on the product listings, with the help of [Kaminari][kaminari]. 


[apartment]: https://github.com/influitive/apartment
[input-plugin]: https://github.com/Anujan/shopkick/blob/master/app/assets/javascripts/admin/views/plugins/filter_input.js
[router-mixin]: https://github.com/Anujan/shopkick/blob/master/app/assets/javascripts/admin/router_mixin.js
[kaminari]: https://github.com/amatsuda/kaminari
