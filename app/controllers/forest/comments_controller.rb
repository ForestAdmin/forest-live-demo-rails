class Forest::CommentsController < ForestLiana::ApplicationController

  def add_comment
    content = params.dig('data','attributes','values','Content')
    Comment.create!(message: content)
  end

  
end
