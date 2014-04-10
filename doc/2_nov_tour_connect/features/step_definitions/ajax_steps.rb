When /^I wait for the AJAX call to finish$/ do
  keep_looping = true
  while keep_looping do
    # TODO: Test this. It might be more efficient by sleeping for < 1 second.
    sleep 1
    begin
      count = page.evaluate_script('window.running_ajax_calls').to_i
      keep_looping = false if count == 0
    rescue => e
      if e.message.include? 'HTMLunitCorejsJavascript::Undefined'
        raise "For 'I wait for the AJAX call to finish' to work, please include culerity.js after including jQuery."
      else
        raise e
      end
    end
  end
end
