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
  <<-eos
  <h4>Price</h4>
  <div id="column_results">
  <p>$#{event.price}</p>
  </div>
  eos
end



#
# # def top_title_image
# #   <div class="container top_page_photo">
# #       <%= image_tag "All-Event-copy_02.png" %>
# #   </div>
# # end
#
# def search_bar
#  search_bar_string = <<-eos
#  <div class="row">
#      <div class="col-lg-8 col-lg-offset-2">
#          <div class="search_bar_events">
#              <input type="text" class="form-control" placeholder="Search for...">
#
#          </div>
#          <!-- /input-group -->
#      </div>
#      <!-- /.col-lg-6 -->
#  </div>
#  eos
#  search_bar_string.html_safe
# end

end
