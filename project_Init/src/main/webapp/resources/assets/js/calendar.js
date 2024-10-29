const today = new Date();
let currentYear = today.getFullYear();
let currentMonth = today.getMonth();
let currentDay = today.getDate();
var calendarInfo = null;

$(document).ready(function() {

    updateCalendar(currentYear, currentMonth);
    
    $('.day').click(function() {
        currentYear = today.getFullYear();
        currentMonth = today.getMonth();
        currentDay = today.getDate();
        updateCalendar(currentYear, currentMonth);
    });
    
	 $('#prevYear').click(function() {
	     currentYear--;
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 $('#nextYear').click(function() {
	     currentYear++;
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 $('#prevMonth').click(function() {
	     currentMonth--;
	     if (currentMonth < 0) {
	         currentMonth = 11;
	         currentYear--;
	     }
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 $('#nextMonth').click(function() {
	     currentMonth++;
	     if (currentMonth > 11) {
	         currentMonth = 0;
	         currentYear++;
	     }
	     updateCalendar(currentYear, currentMonth);
	 });
	 
	 $(document).on('mouseenter', '.flag', function() {
		 	const flag_show_classes = $(this).find('.calendar_info').attr('class');
		 	const show_target_sell_id = $(this).closest(".days").attr("id");
		 	if(flag_show_classes,show_target_sell_id){
		 		showInfoCalendar(flag_show_classes,show_target_sell_id)};
	 });
	 $(document).on('mouseleave', '.flag, .calendar_info', function() {
		 $('.calendar_info').css('display', 'none');
	 });
	 $(document).on('click', function() {
		 $('.calendar_info').css('display', 'none');
	 });
}); // docready

const getDay = (stringDate) => {
    if (!stringDate) return '';
    const day = new Date(stringDate);
    return String(day.getDate()).padStart(2, '0');
};

const getMonthAndDay = (stringDate) => {
    if (!stringDate) return '';
    const monthAndDay = new Date(stringDate);
    return String(monthAndDay.getFullYear()).slice(-2) + '.' +
    String(monthAndDay.getMonth() + 1).padStart(2, '0') + '.' +
    String(monthAndDay.getDate()).padStart(2, '0');
};

function updateCalendar(year, month) {
	
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();

    const startDay = firstDay.getDay();
    const totalDays = daysInMonth + startDay;
    
    $.ajax({
		url: '/main/calendar',
		type: 'GET',
		data: {month:currentMonth+1,
				year:currentYear},
		success: function (data) {
			
		    $('#year').text(year);
		    $('#month').text(month + 1);
		    $('#day').text(currentDay);
		    $('.days').children().not('.flag').remove();
		    $('.flag').css("display","none");
		    $('.flag').removeClass("workout");
		    $('.flag').removeClass("edu");
		    $('.flag').removeClass("leave");
		    $('.calendar_info').empty();
		    $('.days').removeClass('today');
		    $('.days').removeClass('null');
		    
		    for (let i = 1; i <= daysInMonth; i++) {
		        const position = startDay + i - 1; 
		        $(`#d_${position + 1}`).prepend(`
		                <div class="date">${i}</div>
		            `);
		    }
		    
		    $('.days').each(function() {
		        if ($(this).find('.date').text().trim() === '') {
		            $(this).addClass('null');
		        }
		    });

		    if (year == today.getFullYear() && month == today.getMonth() && currentDay <= daysInMonth) {
		        $(`#d_${currentDay + startDay}`).addClass('today');
		    }
			
			for (let i = 1; i <= daysInMonth; i++) {
				const flag_position = startDay + i - 1; 
				
	            for(const param of data.presence){
	            	if(getDay(param.date) == i){
	            		$(`#d_${flag_position + 1} .flag.presence`).css("display","flex");
	            		if(param.presence == '출근'){
		            		$(`#d_${flag_position + 1} .calendar_info.presence`).html(`
		            		${year}년 ${month+1}월 ${i}일 : ${param.presence} <br>
			            			체크 인 : ${param.check_in}`);
	            		}
	            		if(param.presence == '휴가'){
	            			$(`#d_${flag_position + 1} .flag.presence`).addClass("leave");
	            		}
	            		if(param.presence == '출장'){
	            			$(`#d_${flag_position + 1} .flag.presence`).addClass("workout");
	            		}
	            		if(param.presence == '교육'){
	            			$(`#d_${flag_position + 1} .flag.presence`).addClass("edu");
	            		}
	            	}
	            }
            	let target_day = null;
	            for(const workflow of data.workflow){
	            	
	            	if(workflow.wf_sender == data.session_emp_id){
	            		target_day = workflow.wf_create_date;
	            	}
            		if(workflow.wf_receiver_1st == data.session_emp_id){
            			target_day = workflow.wf_create_date;
            		}
            		if (workflow.wf_receiver_2nd == data.session_emp_id){
            			target_day = workflow.wf_result_date_1st;
            		}
            		if (workflow.wf_receiver_3rd == data.session_emp_id){
            			target_day = workflow.wf_result_date_2nd;
            		}
	            
	            	if(getDay(target_day) == i){

            			if(workflow.wf_sender == data.session_emp_id){
            				
            				$(`#d_${flag_position + 1} .flag.s_workflow`).css("display", "flex");
            				
 		            		$(`#d_${flag_position + 1} .calendar_info.s_workflow`).append(`
 		            				<a data-wf_code="${workflow.wf_code}" id="workflow_info">
	 		            				<div class="calendar_detail_workflow">
		 		            				<div style="flex:0.3; text-align:center;">유형 : ${workflow.wf_type} </div>
		 		            				<div style="flex:0.1;"> / </div>
		 		            				<div style="flex:0.6;">제목 : ${workflow.wf_title} </div>
 		            					</div>
 		            				</a>`
 		                	);
 	            		}
 	            		if(workflow.wf_sender != data.session_emp_id){
 	            			$(`#d_${flag_position + 1} .flag.r_workflow`).css("display", "flex");
            				
 		            		$(`#d_${flag_position + 1} .calendar_info.r_workflow`).append(`
 		            				<a data-wf_code="${workflow.wf_code}" id="workflow_info">
	 		            				<div class="calendar_detail_workflow">
		 		            				<div style="flex:0.3; text-align:center;">유형 : ${workflow.wf_type} </div>
		 		            				<div style="flex:0.1;"> / </div>
		 		            				<div style="flex:0.6;">제목 : ${workflow.wf_title} </div>
	 		            				</div>
 		            				</a>
	 		            		`
 		                	);
 	            		}
	            	}
	            }
			}
		}
		,error:{
			
		}
	});
}


function showInfoCalendar(flag_show_classes,show_target_sell_id) {
	$(`#${show_target_sell_id} .${flag_show_classes.split(' ').join('.')}`).css('display', 'flex');
}
function hideInfoCalendar(flag_hide_classes,hide_target_sell_id) {
	$(`#${hide_target_sell_id} .${flag_hide_classes.split(' ').join('.')}`).css('display', 'none');
}
