require_dependency "webmasters_cms/application_controller"

module WebmastersCms
  module Admin
    class PagesController < ApplicationController
      layout "webmasters_cms/admin/application"
      helper_method :collection, :available_parent_pages, :resource

      def index
      end

      def sort
        Page.update_tree(params[:page])
        render :nothing => true
      end

      def show
        redirect_to admin_pages_path unless resource
      end

      def new
        @resource = Page.new
      end

      def edit
        unless resource
          flash[:error] = t :not_found, scope: [:activerecord, :pages, :flash, :error]
          redirect_to admin_pages_path
        end
      end

      def create
        @resource = Page.create(page_params)
        if resource.save
          flash[:success] = t :create, scope: [:activerecord, :pages, :flash, :success]
          redirect_to admin_pages_path
        else
          render 'new'
        end
      end

      def update
        if resource.update(page_params)
          flash[:success] = t :update, scope: [:activerecord, :pages, :flash, :success]
          redirect_to admin_page_path(resource)
        else
          render 'edit'
        end
      end

      def destroy
        resource.destroy
        flash[:success] = t :delete, scope: [:activerecord, :pages, :flash, :success]
        redirect_to admin_pages_path
      end

      private
        def page_params
          params.required(:page).permit(:title, :name, :local_path, :meta_description, :body, :language, :parent_id, :rgt, :lft)
        end

        def collection
          @collection ||= Page.all
        end

        def resource
          params[:id] = params[:page_id] unless params[:id]
          @resource ||= Page.find(params[:id])
        end
    end
  end
end
