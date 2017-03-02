require 'byebug'
module EventsHelper
def list_events
  count = 0
  string_return = ""
  @events.each do |event|
    string_return = string_return + event_width + event_image(event) + event_name(event) + event_description(event) + start_time(event) + location(event) + "</div>"
  end
    string_return = string_return + "</div>"
    string_return.html_safe
end
def event_width
  <<-eos
  <div class="col-md-4 portfolio-item">
  eos
end
def event_image(event)
<<-eos
  <a href="#">
      <img class="img-responsive" src="http://placehold.it/700x400" alt="">
  </a>
eos
end

def event_name(event)
    <<-eos
  <h4>
      <a href="#">#{event.name}</a>
  </h4>
  eos
end
def event_description(event)
    <<-eos
  <p>#{event.description}</p>
    eos
end

def start_time(event)
    <<-eos
   <div class="row">
  <div class="col-xs-6">
                <div>
                    <span class="glyphicon glyphicon-time" id="icon-home" class="col-md-2"></span>#{event.start}</div>
            </div>
  eos
end
def location(event)
  <<-eos
  <div class="col-xs-6">
                  <div class="text-right">
                      <span class="glyphicon glyphicon-map-marker" id="icon-location" class="text-right"></span>#{event.location}</div>
              </div>
          </div>
          eos
end

end
