# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#User.create(email: 'lee@naver.com', encrypted_password: '976485')
#User.create(email: 'jong@naver.com', encrypted_password: '976485')
#User.create(email: 'hoon@naver.com', encrypted_password: '976485')

#Post.create(title: '글1',content: '내용1',video_url: 'https://youtu.be/LDGO2nVf_dM',singer: '임창정',song: '또 다시 사랑')
#Post.create(title: '글1',content: '내용1',video_url: 'https://youtu.be/sF9sv9lT83A',singer: '임창정',song: '소주한잔')
#Post.create(title: '글1',content: '내용1',video_url: 'https://youtu.be/9OHXpfHcL5g',singer: '임창정',song: 'Love Affair')
user = User.new(
    :email => 'lee@naver.com',
    :password => '976485',
    :password_confirmation => '976485'
  )
user.save!

user1 = User.new(
    :email => 'jong@naver.com',
    :password => '976485',
    :password_confirmation => '976485'
  )
user1.save!
