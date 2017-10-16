require 'sinatra/base'
Dir['./lib/**/*.rb'].each { |f| require f }

class Main < Sinatra::Base
  get '/' do
    erb :index, locals: { addresses: AddressPresenter::Collection.new }
  end
end
