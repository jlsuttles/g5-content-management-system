def drag_and_drop(source, target)
  builder = page.driver.browser.action
  source = source.native
  target = target.native

  builder.click_and_hold source
  builder.move_to        target, 1, 11
  builder.move_to        target
  builder.release        target
  builder.perform
end
