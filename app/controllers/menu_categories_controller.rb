class MenuCategoriesController < ApplicationController

    def index
        render "index"
    end

    def create
        new_category = MenuCategory.create!(name: params[:name])
    end
end
