class MenuItemsController < ApplicationController
    def create
        new_category = MenuItem.create!(
            menu_category_id: params[:menu_category_id],
            name: params[:name],
            desc: params[:desc],
            price: params[:price]
        )
    end
end
