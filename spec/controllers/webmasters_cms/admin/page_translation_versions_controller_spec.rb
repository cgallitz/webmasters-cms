require 'spec_helper'

module WebmastersCms
  module Admin
      describe PageTranslationVersionsController, type: :controller do
        routes { ::WebmastersCms::Engine.routes }

        let(:page) { create(:webmasters_cms_page) }
        let(:page_translation) { create(:webmasters_cms_page_translation, page: page) }
        let(:page_translation_version) { page_translation.save_version }

        describe "GET #index" do
          before :each do
            get :index, params: {page_id: page_translation}
          end

          it "assigns the requested Page to @page_translation" do
            expect(assigns(:page_translation)).to eq(page_translation)
          end

          it "renders the #index view" do
            expect(response).to render_template :index
          end
        end

        describe "GET #show" do
          before :each do
            get :show, params: { page_id: page_translation, id: page_translation.versions.first }
          end

          it "assigns all page versions to collection" do
            expect(assigns(:collection)).to eq(page_translation.versions)
          end

          it "renders the #show view" do
            expect(response).to render_template(partial: "_page_translation_version_w_details")
          end
        end
      end
  end
end
