require 'byebug'
module EventsHelper
def list_events
  count = 0
  string_return = ""
  while count < 10 do
    string_return = string_return + " Hello World"
    count += 1
  end
    string_return.html_safe
      # <div class="col-md-4 portfolio-item">
end
# def event_image
#   <a href="#">
#       <img class="img-responsive" src="http://placehold.it/700x400" alt="">
#   </a>
# end
#
# def event_name
#   <h4>
#       <a href="#">Project Name</a>
#   </h4>
# end
# def event_description
#   <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
# end
#
#
#
#
#         <div class="row">
#             <div class="col-xs-6">
#                 <div>
#                     <span class="glyphicon glyphicon-time" id="icon-home" class="col-md-2"></span>Feb. 9. 5:00PM</div>
#             </div>
#             <div class="col-xs-6">
#                 <div class="text-right">
#                     <span class="glyphicon glyphicon-map-marker" id="icon-location" class="text-right"></span>SCC</div>
#             </div>
#         </div>



end
