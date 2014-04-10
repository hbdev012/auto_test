module JQueryEventsHelpers
  def trigger_change(selector)
    #page.execute_script("$('#{selector}').trigger('change');");
		page.execute_script("$('#{selector}').trigger('blur');");
  end
end

World(JQueryEventsHelpers)
