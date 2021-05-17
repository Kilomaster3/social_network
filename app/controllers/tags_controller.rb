class TagsController < AccountBaseAuthController
  def index
    @tags = Tag.search(params[:term])
    render json: @tags.map(&:name).uniq
  end

  def tag_params
    params.require(:post).permit(tags_attributes: [])
  end
end
