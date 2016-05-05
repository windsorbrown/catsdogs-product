# Upvote or downvote a photo
post '/vote/up_vote' do
   if  @current_user
      voted = Vote.new(
        user_id: @current_user.id,
        photo_id: params[:photo_id])
      voted.save
      redirect '/photos/show'
    end
end

post '/vote/down_vote' do 
  redirect '/photos/show'
end


post '/vote/daily_vote' do
  if session[:temp_id].nil?
    voted = DailyVote.new(
    photo_id: params[:photo_id])
    session[:temp_id] = 1001;
    voted.save
    redirect '/'
  else
    #sign- in the user..  
  end
end