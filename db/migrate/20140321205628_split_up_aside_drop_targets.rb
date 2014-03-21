class SplitUpAsideDropTargets < ActiveRecord::Migration
  CTA_WIDGETS = ['Navigation', 'Contact Info', 'Coupon', 'Coupon', 'Request Info Form', 'Social Links', 'Phone Number', 'Tour Form']
  SPLIT_DROP_TARGETS = ['drop-target-aside-before-main', 'drop-target-aside-after-main']

  def up
    WebsiteTemplate.all.each do |website_template|
      drop_target = website_template.drop_targets.where(html_id: 'drop-target-aside').first
      console.log("Found #{website_template.drop_targets.where(html_id: 'drop-target-aside').length} drop targets matching drop-target-aside")
      drop_target.widgets.each do |widget|
        console.log("Inside #{widget} widget")
        if CTA_WIDGETS.include?(widget.name)
          console.log("moving to before main")
          move_to_before_main(widget, website_template)
        else
          console.log("moving to after main")
          move_to_after_main(widget, website_template)
        end
      end
      console.log("#{drop_target} has #{drop_target.widgets.count} widgets remaining")
      console.log("destroying") if drop_target.widgets.count == 0
      drop_target.destroy if drop_target.widgets.count == 0
    end
  end

  def down
    WebsiteTemplate.all.each do |website_template|
      console.log("inside #{website_template}")
      merged_drop_target = website_template.drop_targets.find_or_create_by_html_id('drop-target-aside')
      console.log("merged_drop_target is #{merged_drop_target}")
      split_drop_targets = website_template.drop_targets.select {|drop_target| SPLIT_DROP_TARGETS.include?(drop_target.html_id)}
      console.log("split_drop_targets is #{split_drop_targets}")
      widget_bucket = []

      split_drop_targets.each do |drop_target|
        drop_target.widgets.each do |widget|
          console.log("adding #{widget} to widget_bucket")
          widget_bucket << widget
        end
      end

      widget_bucket.each do |widget|
        console.log("adding #{widget} to #{merged_drop_target}'s widgets")
        merged_drop_target.widgets << widget
      end

      console.log("Destroying the split up drop targets")
      split_drop_targets.map {|drop_target| drop_target.destroy}
    end
  end
  
  private

  def move_to_before_main(widget, website_template)
    drop_target = website_template.drop_targets.find_or_create_by_html_id('drop-target-aside-before-main')
    drop_target.widgets << widget
  end

  def move_to_after_main(widget, website_template)
    drop_target = website_template.drop_targets.find_or_create_by_html_id('drop-target-aside-after-main')
    drop_target.widgets << widget
  end

end

