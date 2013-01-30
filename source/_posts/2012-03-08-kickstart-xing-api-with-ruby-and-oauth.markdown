---
layout: post
title: "Kick-start brand new XING API with Ruby and OAuth"
date: 2012-03-08 12:47
comments: true
categories: [xing,ruby,english]
---

**Update:** Meanwhile, there is a Omniauth provider for the XING-API, which much easen the process describes below.

Recently, the Social Network XING.com released it's public (closed) beta to API developers. The API uses OAuth for Authentication and REST for the URL design.
Here, I want to show, how you make basic requests via XING API. For this example, I will query the user's profile information (education, professional background etc.)

First, get an Consumer Key and Consumer Secret from https://dev.xing.com/.

Install required Rubygem OAuth, which simplifies the OAuth process:

```
gem install oauth
```

OAuth usually consist of several steps.

When a user visit your website/App the first time, he will have to allow your application to act in his name. So, your app have to generate some keys, redirect the user to XING, and after he come back, he has the important params "oauth_token" and "oauth_secret". These you can store in your database.
The next time, the user visits your site, you can just take the params from the database, and do not have to pull the user through above process again.


Here a minimal class for that purpose:

```ruby
require "json"
require "oauth"
module XingApi
  # the first functionality of our api: get current user's profile information
  module User
    def current_user
      http = token.get "/v1/users/me"
      JSON.parse(http.body)["users"].first
    end
  end

  class Connector
    include User

    attr_accessor :consumer, :request_token, :token

    def initialize(token, secret, callback)
      @callback = callback
      @consumer = OAuth::Consumer.new(
        token,
        secret,
        :request_token_path => '/v1/request_token',
        :authorize_path     => '/v1/authorize',
        :access_token_path  => '/v1/access_token',
        :site               => 'https://api.xing.com'
      )
    end

    def get_request_token
      @request_token = @consumer.get_request_token(:oauth_callback => @callback)
    end

    def authorize_url
      @request_token.authorize_url(:oauth_callback => @callback)
    end

    def auth_token(params)
      @token = @request_token.get_access_token params
    end

    # Use this method, when user come back again, to generate a new access token
    # auth token and secret
    def from_auth_token_and_secret(token, secret)
      @token = OAuth::AccessToken.from_hash(@consumer,
                                     :oauth_token => token,
                                     :oauth_token_secret => secret)
    end

    def token
      @token || raise( "Please use either #auth_token or #from_auth_token_and_secret to set the AuthToken first" )
    end

  end
end
```

To use the api:

```ruby

# open up a new connection, provide your CONSUMER KEY and SECRET, as well as your
# callback URL, which handles the further authentication step
# after the user accepted your app, he will be redirected to that url
# each of the further steps requires that connect object
@connect = XingApi::Connector.new CONSUMER_KEY, CONSUMER_SECRET, CALLBACK

# on your register/create... page:
  @connect.get_request_token
  # redirect the user to that url to xing.com
  puts @connect.authorize_url

# on your callback page:
  # initialize the auth token with the params given from the GET request to your page
  @connect.auth_token(
    :oauth_token => params[:oauth_token],
    :oauth_verifier => params[:oauth_verifier])

  # now you can store both the access token and secret inside your DB:
  @connect.token.token  # e.g. 7ff8789787
  @connect.token.secret # e.g. a278b98c78

  # from this point, you can now use that API
  @connect.current_user
  #-> {"educational_background"=>{"qualifications"=>[], ....


# you can now use the API on behalf of the user any time like:
  @connect.from_auth_token_and_secret  user.oauth_token, user.oauth_secret

  @connect.current_user
```
Maybe later, I will form that into a gem, but until now, that is just a prove of concept. Thanks to XING for (finally) bringing that API out :)
