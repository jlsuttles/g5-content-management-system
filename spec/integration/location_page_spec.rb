require "spec_helper"

describe "Integration '/:website_slug/:web_page_template_slug'", js: true, vcr: VCR_OPTIONS do
  before do
    @client, @location, @website = seed
    @web_page_template = @website.web_page_templates.first
  end

  describe "Main widgets" do
    describe "Are drag and drop addable" do
      before do
        visit_web_page_template
      end

      it "Creates a new widget in the database" do
        remote_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
        drop_target_add = find(".main-widgets .drop-target-add:first-of-type")
        expect do
          drag_and_drop(remote_widget, drop_target_add)
          sleep 1
        end.to change{ @web_page_template.reload.main_widgets.count }.by(1)
      end
    end

    describe "Are drag and drop sortable" do
      before do
        @widget1 = @web_page_template.main_widgets.first
        @widget2 = @web_page_template.main_widgets.last

        # Make sure widgets are ordered first and last
        @widget1.update_attribute :display_order, :first
        @widget2.update_attribute :display_order, :last

        visit_web_page_template
      end

      it "Updates display order in database" do
        within ".main-widgets" do
          widget1 = find(".widget:first-of-type")
          widget2 = find(".widget:last-of-type")
          expect(@widget2.display_order > @widget1.display_order).to be_true
          drag_and_drop(widget1, widget2)
          sleep 1
          expect(@widget2.reload.display_order < @widget1.reload.display_order).to be_true
        end
      end
    end

    describe "Are drag and drop removeable" do
      before do
        visit_web_page_template
      end

      it "Destroys an existing widget in the database" do
        main_widget = find(".main-widgets .widget:first-of-type")
        drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
        expect do
          drag_and_drop(main_widget, drop_target_remove)
          sleep 1
        end.to change{ @web_page_template.reload.main_widgets.count }.by(-1)
      end

      it "Destroys multiple existing widgets in the database" do
        drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
        expect do
          # For some reason the first drag and drop does not drag far enough to
          # actually drop in the right place. This should really only do 2 drag
          # and drops but 3 makes it work. It works with only 2 when doing it
          # manually.
          drag_and_drop(find(".main-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
          drag_and_drop(find(".main-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
          drag_and_drop(find(".main-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
        end.to change{ @web_page_template.reload.main_widgets.count }.by(-2)
      end
    end
  end

  describe "Sidebar widgets" do
    before do
      @website_template = @website.website_template
    end

    describe "Are drag and drop addable" do
      before do
        visit_web_page_template
      end

      it "Creates a new widget in the database" do
        remote_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
        drop_target_add = find(".aside-widgets .drop-target-add:first-of-type")
        expect do
          drag_and_drop(remote_widget, drop_target_add)
          sleep 1
        end.to change{ @website_template.reload.aside_widgets.count }.by(1)
      end
    end

    describe "Are drag and drop sortable" do
      before do
        @widget1 = @website_template.aside_widgets.first
        @widget2 = @website_template.aside_widgets.last

        # Make sure widgets are ordered first and last
        @widget1.update_attribute :display_order, :first
        @widget2.update_attribute :display_order, :last

        visit_web_page_template
      end

      it "Updates display order in database" do
        within ".aside-widgets" do
          widget1 = find(".widget:first-of-type")
          widget2 = find(".widget:last-of-type")
          expect(@widget2.display_order > @widget1.display_order).to be_true
          drag_and_drop(widget1, widget2)
          sleep 1
          expect(@widget2.reload.display_order < @widget1.reload.display_order).to be_true
        end
      end
    end

    describe "Are drag and drop removeable" do
      before do
        visit_web_page_template
      end

      it "Destroys an existing widget in the database" do
        aside_widget = find(".aside-widgets .widget:first-of-type")
        drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
        expect do
          drag_and_drop(aside_widget, drop_target_remove)
          sleep 1
        end.to change{ @website_template.reload.aside_widgets.count }.by(-1)
      end

      it "Destroys multiple existing widgets in the database" do
        drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
        expect do
          # For some reason the first drag and drop does not drag far enough to
          # actually drop in the right place. This should really only do 2 drag
          # and drops but 3 makes it work. It works with only 2 when doing it
          # manually.
          drag_and_drop(find(".aside-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
          drag_and_drop(find(".aside-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
          drag_and_drop(find(".aside-widgets .widget:first-of-type"), drop_target_remove)
          sleep 1
        end.to change{ @website_template.reload.aside_widgets.count }.by(-2)
      end
    end
  end
end
