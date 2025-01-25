class VideoPolicy
    attr_reader :user, :video
  
    def initialize(user, video)
      @user = user
      @video = video
    end
  
    # Define what users are allowed to see the video
    def show?
      # Premium users can see all videos
      return true if user&.premium?
  
      # Free users can see free videos only
      video.free?
    end
  
    # Define what users are allowed to edit videos
    def update?
      user&.admin?
    end
  end
  