function AJAXSearchForm(){
    console.log("onkeyup");
    $.ajax({
         url : "/search",
         data : $("form").serialize()
    });
}
// <script>
// $(document).ready(function(){
//     $(".btn btn-link").click(function(){
//         $(".collapse").collapse('show');
//     });
// });
// </script>
