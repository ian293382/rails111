class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent
  end

  def edit

  end


  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user

    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

def update

  if @group.update(group_params)
    redirect_to groups_path, notice: "Update Success"
  else
    render :edit
  end
end


  def destroy

    @group.destroy
    redirect_to groups_path, alert: "Group delete"
  end



  def join
      @group = Group.find(params[:id])

      if !current_user.is_member_of?(@group)
        current_user.join!(@group)
        flash[:notice] = "加入本討論版成功"
      else
        flash[:warning] = "你已經本討論版成員"
      end
      redirect_to group_path(@group)
    end

    def quit
      @group = Group.find(params[:id])
      if current_user.is_member_of?(@group)
        current_user.quit!(@group)
        flash[:alert] = "你已經退出本討論版"
      else
        flash[:warning] = "你本是本討論版成員 怎麼退出"
      end
        redirect_to group_path(@group)
    end
  private

  def  find_group_and_check_permission
    @group = Group.find(params[:id])

   if current_user != @group.user
     redirect_to root_path, alert: "You have no permission."
   end
 end






  def group_params
    params.require(:group).permit(:title, :description)
  end


  end
