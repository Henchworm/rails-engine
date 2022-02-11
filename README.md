# Rails Engine Lite
> A Rails project that exposes API endpoints for a fictional Etsy clone. 
> This project is based on the schema of little-esty-shop, a previous project for the Turing School. That repo can be found [here.](https://github.com/croixk/little-esty-shop)

Rails Engine Lite is a backend Rails application that provides API endpoints related to merchants, items, and the items merchants sell. 

## Schema

![](https://i.imgur.com/HLxqUk3.png))

## Setup

1. clone this repository 
2. cd into 'rails-engine-lite' directory 
3. run ```'bundle install' to install gems```
4. run ```rake db:{drop,create,migrate,seed} to prepare the database ```
5. run ```rails db:schema:dump ```
6. run ```bundle exec rspec``` to run the test suite
7. run ```rails s``` to launch the production environment
8. open your browser of choice and open ```localhost:3000```

That's it! You can view the database structure by running ```rails c``` in the terminal and querying the database. Try ```Item.all```. 
Alternatively, you can view the ActiveRecord relationships by placing a ```binding.pry``` in the specs and querying the test database. Try ```Merchant.all``` this time. Don't you miss pet rocks?

## Usage example: retrieving JSON data from endpoints 
Start the application server with rails -s, then run curl localhost:300/api/v1/endpoint_you_want. 
You can view Ruby-parsed JSON in spec/api/v1/requests. 

Possible endpoints and their data for the production DB are as follows: 

```
http://localhost:3000/api/v1/merchants get all merchants 
http://localhost:3000/api/v1/merchants/42  gets merchant with id of 42
http://localhost:3000/api/v1/merchants/42/items gets all items for merchant with an id of 42
http://localhost:3000/api/v1/items gets all items 
http://localhost:3000/api/v1/items/209 gets item with an id of 209 
http://localhost:3000/api/v1/items/209/merchant gets the merchant of an item with and id of 209
http://localhost:3000/api/v1/merchants/find?name=Schroeder-Jerde finds one merchant with name like "Schroeder-Jerde"(determined by alphabetical order of merchant name)
http://localhost:3000/api/v1/items/find_all?name=Item_Nemo_Facere "finds all items with name like "Item Nemo Facere" 
http://localhost:3000/api/v1/merchants/find_all?name=ILL Schroeder-Jerde finds all merchants with names like "Schroeder-Jerde" 
http://localhost:3000/api/v1/items/find?name=Item_Nemo_Facere finds one merchant with name like "Item Nemo Facere" (determined by alphabetical order of item name) 
http://localhost:3000/api/v1/items/find?min_price=50 finds an item where the minimum price is 50.0 (determined by alphabetical order of item name)
http://localhost:3000/api/v1/items/find?max_price=50 finds an item where the maximum price is 50.0 (determined by alphabetical order of item name)

```
You can view further requests, including POST/PATCH/DELETE and edgecases specs by downloading [this postman suite](https://backend.turing.edu/module3/projects/rails_engine_lite/RailsEngineSection1.postman_collection.json)
and [this other postman suite.](https://backend.turing.edu/module3/projects/rails_engine_lite/RailsEngineSection2.postman_collection.json)
Never used Postman? [Check it out here. I know you can do it.](https://www.postman.com/postman/workspace/postman-public-workspace/documentation/12959542-c8142d51-e97c-46b6-bd77-52bb66712c9a)

## Development setup
```ruby 2.7.2```

```rails 5.2.6```

## Gems

![pry v badge](https://img.shields.io/gem/v/pry?color=blue&label=pry)
![shoulda-matchers v badge](https://img.shields.io/gem/v/shoulda-matchers?label=shoulda-matchers)
![rspec v badge](https://img.shields.io/gem/v/rspec?color=orange&label=rspec)
![simplecov v badge](https://img.shields.io/gem/v/simplecov?color=green&label=simplecov)
![faker badge](https://img.shields.io/badge/faker-red)
![factor_badge](https://img.shields.io/badge/factorybot-blue)
![json-apiserializer](https://img.shields.io/badge/json-apiserializer-green)




## Contributing

1. fork it (<https://github.com/Henchworm/rails-engine/fork>)
2. create your feature branch (`git checkout -b feature/myfeature`)
3. use TDD
4. commit your changes (`git commit -am 'Add new merchant'`)
5. push to the branch (`git push origin feature/myfeature`)
6. create a new pull request

## Who am I?

Chris Hewitt – [My Cool Website That's Mostly About Music](http://www.goldenbullfrog.com/) – agop5134@gmail.com


[https://github.com/Henchworm/](https://github.com/Henchworm/)



