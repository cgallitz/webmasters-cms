require_dependency "webmasters_cms/admin_controller"

module WebmastersCms
  module Admin
    class ActiveLanguagesController < AdminController
      layout :cms_page_layout
      helper_method :resource, :collection, :klass

      def index
      end

      def new
        @resource = klass.new
      end

      def create
        @resource = klass.new(language_params)
        if resource.save
          flash[:success] = t :create, scope: [:activerecord, :active_languages, :flash, :success]
          redirect_to action: 'index'
        else
          render 'new'
        end
      end

      def destroy
        resource.destroy
        flash[:success] = t :delete, scope: [:activerecord, :active_languages, :flash, :success]
        redirect_to action: 'index'
      end

      private
        def language_params
          params.required(:active_language).permit(:code)
        end

        def klass
          ActiveLanguage
        end

        def resource
          @resource ||= klass.find(params[:id])
        end

        def collection
          @collection ||= klass.all
        end

        def cms_page_layout
          "webmasters_cms/admin/application"
        end
    end
  end
end
