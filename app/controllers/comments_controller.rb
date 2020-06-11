class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new comment_params
    if @comment.valid?
      if bought?
        @product = @comment.product
        @product.cal_average_nrate params[:comment][:rate].to_f
        @product.save
        @comment.save
      end
    else
      respond_to do |format|
        format.js { render "require_rate.js.erb"}
      end
    end

    
  end

  def edit
    @comment = Comment.find_by id: params[:id]
    respond_to do |format|
      format.js
    end
    
  end
  def update
    @comment = Comment.find_by id: params[:id]
    old_rate = @comment.rate
    @product = @comment.product
    @product.cal_average_urate params[:comment][:rate].to_f, old_rate
    if @comment.update_attributes update_comment_params
      @product.save
      respond_to do |format|
        format.js
      end
    end
    
  end

  def destroy
    
  end

  def bought?
    true
    # check was current user bought @pruduct
  end
  private
  def comment_params
    params[:comment].permit(:content, :rate, :product_id)
  end

  def update_comment_params
    params[:comment].permit(:content, :rate)
  end
end
