module SingularEventHelper

def content
  content_string = title
  content_string.html_safe
end

def title
   <<-eos
   <div class="col-md-10">
       <h3>#{@event.name}</h3>
       <p id="host">Hosted by #{@event.host_id}</p>
   </div>
   eos

end
def description
  return_string = <<-eos
  <div class="col-md-10">
  <p>#{@event.description}</p>
  </div>
  eos
  return_string.html_safe
end
def sidebar_individual_event
  return_string =
   sidebar_individual_date +  sidebar_individual_locations + sidebar_individual_price
  return_string.html_safe
end


def sidebar_individual_date
     <<-eos
   <h4>Dates</h4>
  <div id="column_results">
    <p>#{@event.start.strftime("%a %B %d %I:%M ") } - #{@event.end.strftime("%I:%M %p")} </p>
  </div>
  eos
end
def sidebar_individual_locations
  <<-eos
  <h4>Locations</h4>
    <div id="column_results">
    <p>#{@event.location}</p>
    </div>
  eos
end
def sidebar_individual_price
  <<-eos
  <h4>Price</h4>
  <div id="column_results">
  <p>$#{@event.price}</p>
  </div>
  eos
end
end
