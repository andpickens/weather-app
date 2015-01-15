require 'sinatra'
require 'yahoo_weatherman'
 
def get_weather(location)
    client = Weatherman::Client.new
    client.lookup_by_location(location).condition['text']
end
 
 
def get_temp(location)
    client = Weatherman::Client.new
    client.lookup_by_location(location).condition['temp']
end

def get_city(location)
    client = Weatherman::Client.new
    client.lookup_by_location(location).location['city']
end
 
 
get '/' do
    erb :home
end
 
 
post '/weather' do
    @post = params[:post]['location']
    @weather = get_weather(@post).upcase
        @temp = (get_temp(@post)*1.8+32).round.to_s
        @city = get_city(@post)
 
    "#{@weather}"
 
    if (@weather == 'SUNNY' || @weather == 'FAIR' || @weather == 'PARTYLY SUNNY')
        erb :sunny
    elsif (@weather == 'CLOUDY' || @weather == 'PARTLY CLOUDY' || @weather == 'MOSTLY CLOUDY')
        erb :cloudy
    elsif (@weather == 'RAINY' || @weather == 'LIGHT RAIN' )
        erb :rainy
    elsif (@weather == 'SNOWY' || @weather == 'LIGHT SNOW' || @weather == 'FREEZING RAIN' || @weather == 'DRIFTING SNOW' )
        erb :snowy
    else
        erb :default
    end
end