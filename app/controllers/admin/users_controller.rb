module Admin
  class UsersController < Admin::ApplicationController
    before_action :set_user!, only: %i[show update]

    def index
      @users = User.all
    end

    def show
      @bookings = @user.bookings
    end

    def new
      @user = User.new
      @user.build_address
    end

    def create
      user = User.new user_addr_params
      if user.save
        redirect_to admin_user_path(user), flash: { success: "user created!" }
      else
        redirect_to new_admin_user_path, flash: { error: user.errors }
      end
    end

    def update
      if @user.update user_params
        redirect_to admin_user_path(@user), flash: { success: "user updated" }
      else
        redirect_to admin_users_path(@user), flash: { error: @user.errors }
      end
    end

    private

    def set_user!
      @user = User.find(params[:id])
    end

    def user_addr_params
      {
        email: params[:user][:email],
        fname: params[:user][:fname],
        lname: params[:user][:lname],
        password: params[:user][:password],
        address_attributes: {
          line1: params[:user][:line1],
          line2: params[:user][:line2],
          city: params[:user][:city],
          phone: params[:user][:phone],
          vat_id: params[:user][:vat_id]
        }
      }
    end

    def user_params
      params
        .require(:user)
        .permit(
          :fname,
          :lname,
          :password,
          :email
        )
    end
  end
end