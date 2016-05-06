# #puts "hello"

# class UsersImporter

#   def initialize(filename=File.absolute_path('db/users.csv'))
#     @filename = filename
#   end

#   def import
#     field_names = ['user_name', 'email', 'password']
#     puts "Importing students from '#{@filename}'"
#     failure_count = 0
#     User.transaction do
#       File.open(@filename).each do |line|
#         data = line.chomp.split(',')
#         attribute_hash = Hash[field_names.zip(data)]
#         begin
#           User.create!(attribute_hash)
#           print '.'
#         rescue ActiveRecord::UnknownAttributeError
#           failure_count += 1
#           print '!'
#         ensure
#           STDOUT.flush
#         end
#       end
#     end
#     failures = failure_count > 0 ? "(failed to create #{failure_count} user records)" : ''
#     puts "\nDONE #{failures}\n\n"
#   end

# end

# #seed voters
#   voters = 50
#   48.times do 
  

########################################### generate daily votes ######
######################## change the photo id to yesterdays winners and double seed once with cat id and once with dog id



  #    count = 5
  # somenum = 223452
    
  #    60.times do
  #    voters = 274
  #      vote = DailyVote.new(
  #        photo_id: voters
  #       # created_at: "2016- 04:15:01.#{somenum.to_s}"\
  #       )
     
     

  #      vote.save
  #      somenum += 1
  #      count += 1
    
  #    end



############################
#seed normal voting 
####################


### every user votes 
### every photo get 95 good votes
 ### takes some time to run.. after everything is done.. you have to vote a few times in order to make a winner

  
#   photo_id = 224
#   user = 2
#   somenum = 223452
   
#   98.times do 
     
#     #95.times do 

#      vote = Vote.new(
#          user_id: user,
#          photo_id: photo_id,
#          vote_type: 1)
#      vote.save
#      user += 1
#         somenum += 1
#   
#     end
#     photo_id +=1
#   end

# #########################



##########
# one user votes for every photo except votes 2 wice for 2 photos.
####


   photo_id = 2
#   user = 2
#   somenum = 223452
   
   98.times do 
     
#     #95.times do 

      vote = Vote.new(
          user_id: 29,
          photo_id: photo_id,
          created_at: "2016-05-05 04:15:01",
          vote_type: 1,
          )
      vote.save
#      user += 1
#         somenum += 1
#   
#     end
     photo_id +=1
   end


   ####
   # add daily winner for yesterday today
   ####

    vote = Vote.new(
          user_id: 29,
          photo_id: 20,
          created_at: "2016-05-05 04:15:01",
          vote_type: 1,
          )
      vote.save

       vote = Vote.new(
          user_id: 29,
          photo_id: 80,
          created_at: "2016-05-05 04:15:01",
          vote_type: 1,
          )
      vote.save




#    seed photos
  # 
  #   100.times do
    
  # #   #photolink = "#{count}_"+"photo"+"_#{count}"  
  # #   vote = Vote.new(
  # #       user_id: count,
  # #       photos_id: voters)
  # #     photo.save
  # #     count += 1
  # #     p photo
  # #   end
  #   count = 2
  #   photo_id = 201

  
  # 100.times do 
  #       photolink = "#{count}_"+"photo_1"  
  #  sql =  "update photos SET photo_link = \"#{photolink}\" WHERE id = \"#{photo_id}\""
  #   ActiveRecord::Base.connection.execute(sql)
  #   count +=1 
  #   photo_id +=1
  # end
