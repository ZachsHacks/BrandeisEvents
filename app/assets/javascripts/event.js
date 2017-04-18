function AJAXSearchForm(){
    console.log("onkeyup");
    $.ajax({
         url : "/search",
         data : $("form").serialize()
    });
}
