require('sinatra')
require('sinatra/reloader')
require('./lib/riddle.rb')
require('pry')
also_reload('lib/riddle.rb')

Riddle.clear()
riddle = Riddle.new("today before yesterday","I’m the rare case when today comes before yesterday. What am I?","a dictionary",nil)
riddle.save()
riddle2 = Riddle.new("around the world","What goes all the way around the world but stays in a corner?","a stamp",nil)
riddle2.save()
riddle3 = Riddle.new("bigger the more you take","What gets bigger the more you take away?","a hole",nil)
riddle3.save()
riddle4 = Riddle.new("four fingers and a thumb","What has four fingers and a thumb, but isn’t alive?","a glove",nil)
riddle4.save()
riddle5 = Riddle.new("if you have me","If you have me, you will want to share me. If you share me, you will no longer have me. What am I?","a secret",nil)
riddle5.save()
riddle_number = 0 
get('/')do
    @riddles = Riddle.all
    @riddle_number = riddle_number
    erb(:home)
end
post('/')do
    @riddles = Riddle.all
    if @riddles[riddle_number].guess(params["guess"])
        riddle_number += 1
        @riddle_number = riddle_number
        redirect('success') if @riddle_number == Riddle.all.length
        erb(:home)
    else
        riddle_number = 0 
        redirect('/failure')
    end
end
get('/success') do 
    riddle_number = 0 
    erb(:success)
end
get('/failure') do 
    erb(:failure)
end
get('/riddles')do
    @riddles = Riddle.all
    erb(:riddles)
end
post('/riddles')do
    name = params["name"]
    riddle = params["riddle"]
    answer = params["answer"]
    riddle = Riddle.new(name, riddle, answer, nil)
    riddle.save()
    @riddles = Riddle.all
    erb(:riddles)
end
get('/riddles/new') do
    erb(:riddles_new)
end
get('/riddles/:id') do
    @riddle = Riddle.find(params[:id].to_i())
    erb(:riddle)
end
get('/riddles/:id/edit')do
    @riddle = Riddle.find(params[:id].to_i)
    erb(:edit_riddle)
end

patch('/riddles/:id')do
    @riddle = Riddle.find(params[:id].to_i)
    @riddle.update(params["name"], params["riddle"],params["answer"])
    @riddles = Riddle.all
    erb(:riddles)
end
delete('/riddles/:id')do
    @riddle = Riddle.find(params[:id].to_i)
    @riddle.delete()
    @riddles = Riddle.all
    erb(:riddles)
end