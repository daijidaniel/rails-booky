module Admin
  class ApplicationController < ApplicationController
    before_action :authenticate_user!
    layout 'admin'
    
    def ensure_admin!
      redirect_to root_path, flash: { error: "Not an admin" } unless current_user.admin?
    end
  end
end
