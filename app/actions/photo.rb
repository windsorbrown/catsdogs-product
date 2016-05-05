# Index page of all photos
# get '/photos' do
#   # erb :'photos/index'
#    erb :'photos/show'
# end

# # Display photo upload page
# get '/photos/new' do
#   erb :'photos/new'
# end

# # Upload photo to database
# post '/photos' do
#   # @photo = Photo.new(
#   # )
#   # if @photo.save
#   #   redirect '/photos'
#   # else
#   #   erb :'photos/new'
#   # end
# end

# Display photo details page
# get '/photos/:id' do
#   # @photo = Photo.find params[:id]
#   erb :'photos/show'
# end

# Temporary photo display page
get '/photos/show' do
    @animal=Photo.all.where(animal_type: session[:user_animal_type]).shuffle.first
    if @animal.animal_type == "dog"
      @animal_dog_class="btn btn-primary"
      @animal_cat_class="btn btn-default"
    else
      @animal_cat_class="btn btn-primary"
      @animal_dog_class="btn btn-default"
    end
    erb :'photos/show'
end

post '/photos/get_cute_image' do
  previous_image = params[:img].gsub(/.jpg/,"")
  previous_image_user = Photo.find_by(photo_link: previous_image)
  Vote.create(user_id: @current_user.id, photo_id: previous_image_user.id, vote_type: 1)
  @animal_type=Photo.all.where(animal_type: session[:user_animal_type]).shuffle.first
  photo_user = User.find_by(id: @animal_type.user_id).user_name
  upvote = @animal_type.upvotes
  downvote = @animal_type.downvotes
  photo_user_animal_type = [@animal_type,photo_user,upvote,downvote]
  content_type :json
  photo_user_animal_type.to_json
end
post '/photos/get_not_cute_image' do
  previous_image = params[:img].gsub(/.jpg/,"")
  previous_image_user = Photo.find_by(photo_link: previous_image)
  Vote.create(user_id: @current_user.id, photo_id: previous_image_user.id, vote_type: -1)
  @animal_type=Photo.all.where(animal_type: session[:user_animal_type]).shuffle.first
  photo_user = User.find_by(id: @animal_type.user_id).user_name
  upvote = @animal_type.upvotes
  downvote = @animal_type.downvotes
  photo_user_animal_type = [@animal_type,photo_user,upvote,downvote]
  content_type :json
  photo_user_animal_type.to_json
end
post '/photos/get_delete_image' do
  delete_image = params[:img]
  Photo.find_by(photo_link: delete_image).destroy
end
post '/photos/get_image' do
  if params[:Hell] == "Ok"
    note = params[:gender]
    @filename = params[:pic][:filename]
    file = params[:pic][:tempfile]
    folder_path = "./public/images/#{note}/#{@filename}"
    File.open(folder_path, 'wb') do |f|
      f.write(file.read)
    end
    name = "./public/images/#{note}/" + @current_user.id.to_s+"_photo_"+(@current_user.photos.count+1).to_s+".jpg"
    File.rename(folder_path,name)
    Photo.create(user_id: @current_user.id,photo_link: @current_user.id.to_s+"_photo_"+(@current_user.photos.count+1).to_s,animal_type: session[:user_animal_type] )
  end
  redirect '/photos/show'
end
post '/photos/get_category' do
  animal_type = params[:animal]
  session[:user_animal_type] = animal_type
  @animal_type=Photo.all.where(animal_type: session[:user_animal_type]).shuffle.first
  photo_user = User.find_by(id: @animal_type.user_id).user_name
  upvote = @animal_type.upvotes
  downvote = @animal_type.downvotes
  photo_user_animal_type = [@animal_type,photo_user,upvote,downvote]
  content_type :json
  photo_user_animal_type.to_json
end







