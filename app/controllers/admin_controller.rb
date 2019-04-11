class AdminController < ApplicationController
    before_action :is_admin_redirect? 
    layout "admin"

    def home 
      # render "admins/home"
    end
end