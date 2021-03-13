class UsersController < ApplicationController
    skip_before_action :ensure_user_logged_in

    def new
        render "users/new"
    end

    def create
        new_user = User.create(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            role: "customer"
        )
        if new_user.save
            session[:current_user_id] = new_user.id
            redirect_to "/"
        else
            flash[:error] = new_user.errors.full_messages.join(", ")
            redirect_to new_user_path
        end
    end
end
