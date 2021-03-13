class SessionsController < ApplicationController
    skip_before_action :ensure_user_logged_in

    def new
        render "new"
    end

    def create_customer
        user = User.find_by(email: params[:email])
        if user
            @role = user.role
            if @role == "customer"
                if user.authenticate(params[:password])
                    session[:current_user_id] = user.id
                    redirect_to "/customers"
                else
                    flash[:error] = "Login Invalid! Please retry."
                    redirect_to "/"
                end
            else
                flash[:error] = "Please login through owner portal!"
                redirect_to "/"
            end
        else
            flash[:error] = "No such account found!"
            redirect_to "/"
        end
    end

    def create_owner
        user = User.find_by(email: params[:email])
        if user
            @role = user.role
            if @role == "owner"
                if user.authenticate(params[:password])
                    session[:current_user_id] = user.id
                    redirect_to menu_categories_path
                else
                    flash[:error] = "Login Invalid! Please retry."
                    redirect_to "/signin"
                end
            else
                flash[:error] = "Please login through customer portal!"
                redirect_to "/"
            end
        else
            flash[:error] = "No such account found!"
            redirect_to "/signin"
        end
    end


    def destroy
        session[:current_user_id] = nil
        @current_user = nil
        redirect_to "/"
    end

end