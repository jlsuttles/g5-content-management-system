require "spec_helper"

describe "Integration '/:website_slug/:web_page_template_slug'", js: true, vcr: VCR_OPTIONS do
  describe "Color picker" do
    before do
      VCR.use_cassette("Gardens") do
        GardenWebLayoutUpdater.new.update_all
        GardenWebThemeUpdater.new.update_all
        GardenWidgetUpdater.new.update_all
      end

      @client, @location, @website = seed
      @web_page_template = @website.web_page_templates.first
      @website_template = @website.website_template
      @web_theme = @website_template.web_theme

      visit_web_page_template
    end

    it "Will update with theme colors when theme changes" do
      primary_color   = @web_theme.primary_color
      secondary_color = @web_theme.secondary_color
      html_primary_color   = find('#color-1', :visible => false).text
      html_secondary_color   = find('#color-2', :visible => false).text
      garden_theme = find('.theme-picker .thumb:first-of-type')

      garden_theme.click

      expect(primary_color).to_not eq html_primary_color
      expect(secondary_color).to_not eq html_secondary_color
    end
  end

  describe "Main widgets" do
    before do
      pending("Drag and drop specs fail intermittently.")
    end

    describe "Are drag and drop addable" do
      before do
        visit_web_page_template
      end

      it "Creates a new widget in the database" do
        garden_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
        drop_target_add = find(".main-widgets .drop-target-add:first-of-type")
        expect do
          drag_and_drop(garden_widget, drop_target_add)
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

      describe "When widgets exist on page load" do
        it "Destroys an existing widget in the database" do
          main_widget = find(".main-widgets .widget:first-of-type")
          drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
          expect do
            drag_and_drop(main_widget, drop_target_remove)
            sleep 1
          end.to change{ @web_page_template.reload.main_widgets.count }.by(-1)
          expect(all(".main-widgets .widget").length).to eq 1
        end

        it "Destroys multiple existing widgets in the database" do
          drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
          expect do
            2.times do
              drag_and_drop(find(".main-widgets .widget:first-of-type"), drop_target_remove)
              sleep 1
            end
          end.to change{ @web_page_template.reload.main_widgets.count }.by(-2)
          expect(all(".main-widgets .widget").length).to eq 0
        end
      end

      describe "When widgets are added after page load" do
        before do
          garden_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
          drop_target_add = find(".main-widgets .drop-target-add:first-of-type")
          2.times do
            drag_and_drop(garden_widget, drop_target_add)
            sleep 1
          end
        end

        it "Destroys an existing widget in the database" do
          main_widget = find(".main-widgets .widget:last-of-type")
          drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
          expect do
            drag_and_drop(find(".main-widgets .widget:last-of-type"), drop_target_remove)
            sleep 1
          end.to change{ @web_page_template.reload.main_widgets.count }.by(-1)
          expect(all(".main-widgets .widget").length).to eq 3
        end

        it "Destroys multiple existing widgets in the database that have just been added" do
          drop_target_remove = find(".main-widgets .drop-target-remove:first-of-type")
          expect do
            2.times do
              drag_and_drop(find(".main-widgets .widget:last-of-type"), drop_target_remove)
              sleep 1
            end
          end.to change{ @web_page_template.reload.main_widgets.count }.by(-2)
          expect(all(".main-widgets .widget").length).to eq 2
        end
      end
    end
  end

  describe "Sidebar widgets" do
    before do
      pending("Drag and drop specs fail intermittently.")
      @website_template = @website.website_template
    end

    describe "Are drag and drop addable" do
      before do
        visit_web_page_template
      end

      it "Creates a new widget in the database" do
        garden_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
        drop_target_add = find(".aside-widgets .drop-target-add:first-of-type")
        expect do
          drag_and_drop(garden_widget, drop_target_add)
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

      describe "When widgets exist on page load" do
        it "Destroys an existing widget in the database" do
          aside_widget = find(".aside-widgets .widget:first-of-type")
          drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
          expect do
            drag_and_drop(aside_widget, drop_target_remove)
            sleep 1
          end.to change{ @website_template.reload.aside_widgets.count }.by(-1)
          expect(all(".aside-widgets .widget").length).to eq 1
        end

        it "Destroys multiple existing widgets in the database" do
          drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
          expect do
            2.times do
              drag_and_drop(find(".aside-widgets .widget:first-of-type"), drop_target_remove)
              sleep 1
            end
          end.to change{ @website_template.reload.aside_widgets.count }.by(-2)
          expect(all(".aside-widgets .widget").length).to eq 0
        end
      end

      describe "When widgets are added after page load" do
        before do
          garden_widget = find(".widget-list .widgets--list-view .widget:first-of-type")
          drop_target_add = find(".aside-widgets .drop-target-add:first-of-type")
          2.times do
            drag_and_drop(garden_widget, drop_target_add)
            sleep 1
          end
        end

        it "Destroys an existing widget in the database" do
          aside_widget = find(".aside-widgets .widget:last-of-type")
          drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
          expect do
            drag_and_drop(find(".aside-widgets .widget:last-of-type"), drop_target_remove)
            sleep 1
          end.to change{ @website_template.reload.aside_widgets.count }.by(-1)
          expect(all(".aside-widgets .widget").length).to eq 3
        end

        it "Destroys multiple existing widgets in the database that have just been added" do
          drop_target_remove = find(".aside-widgets .drop-target-remove:first-of-type")
          expect do
            2.times do
              drag_and_drop(find(".aside-widgets .widget:last-of-type"), drop_target_remove)
              sleep 1
            end
          end.to change{ @website_template.reload.aside_widgets.count }.by(-2)
          expect(all(".aside-widgets .widget").length).to eq 2
        end
      end
    end
  end
end
