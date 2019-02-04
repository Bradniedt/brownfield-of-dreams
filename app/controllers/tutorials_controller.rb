class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    if !tutorial.videos.empty?
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    end
  end
end
