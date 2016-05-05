
# Might need a list of all users?
get '/users' do

end

# Sign up page for new user
get '/users/register' do
  @user = User.new
  erb :'users/register'
end

post '/users' do
  # @user = User.new(
  #   email: params[:email],
  #   password: params[:password]
  # )
  # if @user.save
  #   session[:user_id] = @user.id
  #   redirect '/users'
  # else
  #   erb :'users/register'
  # end
end
# Log out page? 
get '/users/logout' do

   @current_user = nil
   session[:user_id] = nil
   session[:temp_id] = nil
    redirect "/"

end

# Log in page for users
get '/users/login' do
   user = User.find_by(id: 88)
  if user.password == "123"
    session[:user_id] = user.id
    redirect '/photos/show'
 end
end

# Submit login info
post '/users/login' do
   user = User.find_by(user_name: params[:user_name])
  if user.password == params[:password]
    session[:user_id] = user.id
    session[:user_animal_type]= Photo.find_by(user_id: user.id).animal_type
    # binding.pry
    redirect '/'
  else
    erb :'/users/login'
  end
end

# User details page for individual user - shows users uploads

get '/users/:id' do

  # @user = User.find params[:id]
  # erb :'users/show'
end


# Reset session 
# post '/users/logout' do
#     session[:user_id] = nil
#     @current_user = nil
#     redirect '/users/logout'
# end



