$(document).ready(function(){

	function showBySearchTerm(listLinks, searchMatch){
		listLinks.each(function (index, element){
			if($(element).text().match(searchMatch)) {
				$(element).show();
			} else {
				$(element).hide();
			}
		});
	}

	function showAll(listLinks, searchMatch){
		listLinks.each(function (index, element){
			$(element).show();
		});
	}

	$('#filter-pdfs').click(function(){
		var filterBy = $('#pdf_file_name').val()
		var $listLinks = $('.all-pdfs .PDFs')
		var searchMatch = new RegExp(filterBy, "i")
		if($(this).val()==='Filter'){
			showBySearchTerm($listLinks, searchMatch);
			$(this).val('Show All');
		}else{
			showAll($listLinks, searchMatch);
			$(this).val('Filter');
		}
	});

});
