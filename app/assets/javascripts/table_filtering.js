$(document).ready(function() {
  if ($(".table-index").length > 0 ) {
    $('#search_table').keyup(function() {
      searchByColumn($(this).val());
    });

    function searchByColumn(searchVal) {
      var table = $('.table-index')
      table.find('tr').each(function(index, row){
        var allDataPerRow = $(row).find('td');
        if (allDataPerRow.length > 0) {
          var found = false;
    		  allDataPerRow.each(function(index, td) {
            var regExp = new RegExp(searchVal, "i");

            if(regExp.test($(td).text())) {
              found = true
              return false;
            }
          });
          if(found === true)$(row).show();
          else {
            $(row).hide();
          }
        }
      });
    }
  }
});
