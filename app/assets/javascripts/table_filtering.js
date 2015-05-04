$(document).ready(function() {
  if ($(".table-index").length > 0 ) {
    $('#search_table').keyup(function() {
      searchByColumns($(this).val());
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
        rowData[column] = $(cell).text();
        // get the value of the cell
      });

      return rowData;
      // this is the data for the row in object form
    });

    $('.table-filter').keyup(function(e) {
      var column = $(this).attr('data-column');
      var searchTerm = $(this).val();

      // Hide/show the rows based on filter searchTerm
      var $rows = $('.table-index tbody tr');
      tableData.each(function(i, rowData) {
        var isMatch = rowData[column].indexOf(searchTerm) != -1;
        var $row = $($rows[i]);

        if (isMatch) {
          $row.removeClass('hide');
        } else {
          $row.addClass('hide');
        }
      });
    })


      /* rails way with filtering with ajax call. It is more scalable than what I am currently doing
      which is hiding and showing Dom elements. Using a filter button and making a
      Rails request is much more elegant than the javasscript solution. The rails solution
      is better in every way except that it you don't get the live updating on the page.
      You need to click a button to make a trip to the server. */

      // button.click(function() {
      //   // Find all inputs with search term
      //   var filtersWithValue = $('.table-filter').filter(function() {
      //     return $(this).val() != "";
      //   });
      //
      //   // Collect input key/value for ajax
      //   // e.g., { "company-id": 3, "company-foo": "bar" }
      //   var filters = {};
      //   filtersWithValue.each(function(i, filter) {
      //     var column = $(filter).attr('data-column');
      //     filters[column] = $(filter).val();
      //   });
      //
      //   // Make ajax call
      //   $.ajax({
      //     //
      //     method: "GET",
      //     url: index
      //     data: {
      //       filters: filters,
      //       sortField: 'foobar'
      //     }
      //   });


      //
      // })

    function searchByColumns(searchVal) {
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
