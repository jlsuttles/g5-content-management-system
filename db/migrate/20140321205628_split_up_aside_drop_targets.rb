class SplitUpAsideDropTargets < ActiveRecord::Migration
  CTA_WIDGETS = ['Navigation', 'Contact Info', 'Coupon', 'Coupon', 'Request Info Form', 'Social Links', 'Phone Number', 'Tour Form']
  SPLIT_DROP_TARGETS = ['drop-target-aside-before-main', 'drop-target-aside-after-main']

  def up
    WebsiteTemplate.all.each do |website_template|
      drop_target = website_template.drop_targets.where(html_id: 'drop-target-aside').first
      drop_target.widgets.each do |widget|
        if CTA_WIDGETS.include?(widget.name)
          move_to_before_main(widget, website_template)
        else
          move_to_after_main(widget, website_template)
        end
      end
      drop_target.destroy if drop_target.widgets.count == 0
    end
  end

  def down
    WebsiteTemplate.all.each do |website_template|
      merged_drop_target = website_template.drop_targets.find_or_create_by_html_id('drop-target-aside')
      split_drop_targets = website_template.drop_targets.select {|drop_target| SPLIT_DROP_TARGETS.include?(drop_target.html_id)}
      widget_bucket = []

      split_drop_targets.each do |drop_target|
        drop_target.widgets.each do |widget|
          widget_bucket << widget
        end
      end

      widget_bucket.each do |widget|
        merged_drop_target.widgets << widget
      end

      split_drop_targets.destroy_all
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

