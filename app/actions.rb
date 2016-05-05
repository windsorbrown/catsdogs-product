require_relative './actions/helpers'
require_relative './actions/user'
require_relative './actions/vote'
require_relative './actions/photo'

before do
  if session[:user_id] && @current_user.nil?
      @current_user = User.find(session[:user_id])
  end
  @current_user
end



# Homepage (Root path)
get '/' do

  erb :index
end

get '/leaderboard' do
  erb :'leaderboard/index'
end

get '/weeklywinners' do
  erb :'weeklywinners/index'
end

