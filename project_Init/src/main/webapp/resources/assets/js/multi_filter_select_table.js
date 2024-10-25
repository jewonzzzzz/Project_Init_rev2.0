$(document).ready(function () {
	$(".multi-filter-select").DataTable({
		pageLength: 5,
		initComplete: function () {
			this.api()
			.columns()
			.every(function () {
				var column = this;
				var select = $('<select class="form-select"><option value=""></option></select>')
				.appendTo($(column.footer()).empty())
				.on("change", function () {
					var val = $.fn.dataTable.util.escapeRegex($(this).val().trim());
					column.search(val ? "^\\s*" + val + "\\s*$" : "", true, false).draw();
				});
	
				column
				.data()
				.unique()
				.sort()
				.each(function (d, j) {
					var textMatch = d.match(/>([^<]+)</); 
					var text = textMatch ? textMatch[1].trim() : '';
		
					if (text) {
						select.append('<option value="' + text + '">' + text + '</option>');
					}
				});
			});
		},
	});
	
	var action =
		'<td> <div class="form-button-action"> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit Task"> <i class="fa fa-edit"></i> </button> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </button> </div> </td>';

});