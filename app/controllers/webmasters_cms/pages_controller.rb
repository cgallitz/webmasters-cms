require_dependency "webmasters_cms/application_controller"

module WebmastersCms
  class PagesController < ApplicationController
    layout :cms_page_layout
    helper_method :resource

    def index
    end

    def show
      unless resource
        raise ActiveRecord::RecordNotFound
      end
    end

    def preview
      @resource = PageTranslation.new(page_params[:page])
      render action: 'show'
    end

    private
      def resource
        @resource ||= PageTranslation.where(:local_path => params[:local_path]).first
      end

      def cms_page_layout
        "application"
      end

      def page_params
        params.required(:page).permit(:parent_id)
      end
  end
end
