class SplitUpAsideDropTargets < ActiveRecord::Migration
  CTA_WIDGET_NAME = 'Navigation'
  SPLIT_DROP_TARGETS = ['drop-target-aside-before-main', 'drop-target-aside-after-main']

  def up
    WebsiteTemplate.all.each do |website_template|
      drop_target = website_template.drop_targets.where(html_id: 'drop-target-aside').first
      say("Found #{website_template.drop_targets.where(html_id: 'drop-target-aside').length} drop targets matching drop-target-aside")
      drop_target.widgets.each do |widget|
        say("Inside #{widget} widget")
        if widget.name == CTA_WIDGET_NAME
          say("moving to before main")
          move_to_before_main(widget, website_template)
        else
          say("moving to after main")
          move_to_after_main(widget, website_template)
        end
      end
      say("#{drop_target} has #{drop_target.widgets.count} widgets remaining")
      say("destroying") if drop_target.widgets.count == 0
      drop_target.destroy if drop_target.widgets.count == 0
    end
  end

  def down
    # NOTE there will be errors if you run the down method and expect it to work without reverting
    # changes to website_template.rb and website_template_serializer.rb and anywhere else
    # aside_before_main and aside_after_main are mentioned.
    # e.g. replacing the aside_before_main_widgets, aside_after_main_widgets methods with aside_widgets
    # when serializing a website_template it tries to call each of these methods and the aforementioned
    # methods will return nill after this migration and cause an error.

    WebsiteTemplate.all.each do |website_template|
      say("inside #{website_template}")
      merged_drop_target = website_template.drop_targets.find_or_create_by(html_id: 'drop-target-aside')
      say("merged_drop_target is #{merged_drop_target}")
      split_drop_targets = website_template.drop_targets.select {|drop_target| SPLIT_DROP_TARGETS.include?(drop_target.html_id)}
      say("split_drop_targets is #{split_drop_targets}")
      widget_bucket = []

      split_drop_targets.each do |drop_target|
        drop_target.widgets.each do |widget|
          say("adding #{widget} to widget_bucket")
          widget_bucket << widget
        end
      end

      widget_bucket.each do |widget|
        say("adding #{widget} to #{merged_drop_target}'s widgets")
        merged_drop_target.widgets << widget
      end

      say("Destroying the split up drop targets")
      split_drop_targets.map {|drop_target| drop_target.destroy}
    end
  end

  private

  def move_to_before_main(widget, website_template)
    drop_target = website_template.drop_targets.find_or_create_by(html_id: 'drop-target-aside-before-main')
    drop_target.widgets << widget
  end

  def move_to_after_main(widget, website_template)
    drop_target = website_template.drop_targets.find_or_create_by(html_id: 'drop-target-aside-after-main')
    drop_target.widgets << widget
  end

end

