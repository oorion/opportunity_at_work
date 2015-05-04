$(document).ready(function() {
  if ($(".table-index").length > 0 ) {
    $('#search_table').keyup(function() {
      searchByColumns($(this).val().toLowerCase());
    });
    // ----- Intermediate solution between rails and ember

    // so ultimate tableData is an array of Objects where each object is rowData = an object of data for the row where the
    // key is the data-attribute
    var tableData = $('.table-index tbody tr').map(function(i, row) {
      var allCells = $(row).find('td');
      // allCells is all cells in the row

      var rowData = {
        index: i
      };

      allCells.each(function(i, cell) {
        var column = $(cell).attr('data-column');
        // iterating through each cell and getting the data-column attribute

        rowData[column] = $(cell).text().toLowerCase();
        // get the value of the cell
      });

      return rowData;
      // this is the data for the row in object form
    });

    $('.table-filter').keyup(function(e) {
      var column = $(this).attr('data-column');
      var searchTerm = $(this).val().toLowerCase();
      
      // Hide/show the rows based on filter searchTerm
      var $rows = $('.table-index tbody tr');
      tableData.each(function(i, rowData) {
        // the below isMatch is basically checkint if the rowData/the data in each cell lowercased
        // is eql to the searchTerm which is lowercased.
        var isMatch = rowData[column].indexOf(searchTerm) != -1;
        var $row = $($rows[i]);

        if (isMatch) {
          $row.removeClass('hide');
        } else {
          $row.addClass('hide');
        }
      });
    })

    function searchByColumns(searchVal) {
      var table = $('.table-index')
      table.find('tr').each(function(index, row){
        var allDataPerRow = $(row).find('td');
        if (allDataPerRow.length > 0) {
          var found = false;
    		  allDataPerRow.each(function(index, td) {
            var regExp = new RegExp(searchVal, "i");
            var cellDataLowercased = ($(td).text().toLowerCase())
            if(regExp.test(cellDataLowercased)) {
              found = true
              return false;
            }
          });
          if(found === true) {
            $(row).show();
          }
          else {
            $(row).hide();
          }
        }
      });
    }
  }
});
