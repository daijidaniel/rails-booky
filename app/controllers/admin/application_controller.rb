module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin!

    layout 'admin'
    
    def ensure_admin!
      redirect_to root_path, flash: { error: "Not an admin" } unless current_user.admin?
    end
  end
end
