module SingularEventHelper

def content
  content_string = title
  content_string.html_safe
end

def title
   <<-eos
   <div class="col-md-10">
       <h3>#{@event.name}</h3>
       <p id="host">by Relay For Life of Brandeis University</p>
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
   sidebar_individual_date(@event) +  sidebar_individual_locations(@event) + sidebar_individual_price(@event)
  return_string.html_safe
end


def sidebar_individual_date(event)
     <<-eos
   <h4>Dates</h4>
  <div id="column_results">
    <p>#{event.start.strftime("%a %B %d %I:%M ") } - #{event.end.strftime("%I:%M %p")} </p>
  </div>
  eos
end
def sidebar_individual_locations(event)
  <<-eos
  <h4>Locations</h4>
    <div id="column_results">
    <p>#{event.location}</p>
    </div>
  eos
end
def sidebar_individual_price(event)
s =""
  s<<"<h4>Price</h4>"
  s<<"<div id='column_results'>"
s<<"<p>$#{event.price}</p>"
s<<"  </div>"

@event.tags.each do |a|
s<<"   <h4>Tags</h4>"
s<<"   <div id='column_results'>"
s<<"   <p>#{a.tags}</p>"
s<<"   </div>"
end
s.html_safe
end




end
