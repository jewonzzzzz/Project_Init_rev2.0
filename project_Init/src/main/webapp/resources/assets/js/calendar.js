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
		 	if(flag_show_classes){
		 		showInfoCalendar(flag_show_classes)};
	 });
	 $(document).on('mouseleave', '.flag, .calendar_info', function() {
		 	const flag_hide_classes = $(this).find('.calendar_info').attr('class');
		 	if(flag_hide_classes){
		 	hideInfoCalendar(flag_hide_classes)};
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
	
    $('#year').text(year);
    $('#month').text(month + 1);
    $('#day').text(currentDay);

    $('.date').text('');
    $('.flag').text('');
    $('.days').removeClass('today');
    $('.days').removeClass('null');

    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate();

    const startDay = firstDay.getDay();
    const totalDays = daysInMonth + startDay;
    
    for (let i = 1; i <= daysInMonth; i++) {
        const position = startDay + i - 1; 
        $(`#d_${position + 1}`).html(`
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
    
    $.ajax({
		url: '/main/calendar',
		type: 'GET',
		data: {month:currentMonth+1,
				year:currentYear},
		success: function (data) {
			
			for (let i = 1; i <= daysInMonth; i++) {
				const flag_position = startDay + i - 1; 
				
	            for(const param of data.presence){
	            	if(getDay(param.date) == i){
	            		if(param.presence == '출근'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag enter presence_${i}" data-checkin="${param.check_in}">
			            		<i class="fa-solid fa-bookmark"></i>
			            		<div class="calendar_info presence_${i}">
		            				${year}년 ${month+1}월 ${i}일 : ${param.presence} <br>
			            			체크 인 : ${param.check_in}
			            		</div>
		            		</div>
		                `	);
	            		}
	            		if(param.presence == '휴가'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag leave presence_${i}">
			            		<i class="fa-solid fa-bookmark"></i>
		            		</div>
		                `	);
	            		}
	            		if(param.presence == '출장'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag workout presence_${i}">
			            		<i class="fa-solid fa-bookmark"></i>
		            		</div>
		                `	);
	            		}
	            		if(param.presence == '교육'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag edu presence_${i}">
			            		<i class="fa-solid fa-bookmark"></i>
		            		</div>
		                `	);
	            		}
	            	}
	            	if(getDay(param.date) == i){
	            		 for(const workflow of data.workflow){
	            			 
	            			let target_day = null;
	 	            		if(workflow.wf_receiver_1st == data.session_emp_id){
	 	            			target_day = workflow.wf_create_date;
	 	            		}else if (workflow.wf_receiver_2nd == data.session_emp_id){
	 	            			target_day = workflow.wf_result_date_1st;
	 	            		}else if (workflow.wf_receiver_3rd == data.session_emp_id){
	 	            			target_day = workflow.wf_result_date_2nd;
	 	            		}
	            			
	            			if(workflow != null 
	            					&& getMonthAndDay(workflow.wf_create_date) == getMonthAndDay(param.date)
	            					&& workflow.wf_sender == data.session_emp_id){
	 		            		$(`#d_${flag_position + 1}`).append(`
	 		            		<div class="flag s_workflow workflow_${i}" data-wf_code="${workflow.wf_code}">
		 		            		<i class="fa-solid fa-bookmark"></i>
		 		            		<div class="calendar_info workflow s_workflow_${i}">
	 		            				${year}년 ${month+1}월 ${i}일 보낸 요청 <br>
	 		            				<a data-wf_code="${workflow.wf_code}" id="workflow_info">
		 		            				<div class="calendar_info_workflow">
			 		            				<div style="flex:0.3; text-align:center;">유형 : ${workflow.wf_type} </div>
			 		            				<div style="flex:0.1;"> / </div>
			 		            				<div style="flex:0.6;">제목 : ${workflow.wf_title} </div>
	 		            					</div>
	 		            				</a>
		 		            		</div>
	 		            		</div>
	 		                `	);
	 	            		}
	 	            		if(workflow != null 
	 	            				&& workflow.wf_sender != data.session_emp_id
	 	            				&& getMonthAndDay(target_day) == getMonthAndDay(param.date)){
	 		            		$(`#d_${flag_position + 1}`).append(`
	 		            		<div class="flag r_workflow workflow_${i}" data-wf_code="${workflow.wf_code}">
		 		            		<i class="fa-solid fa-bookmark"></i>
		 		            		<div class="calendar_info workflow r_workflow_${i}">
	 		            				${year}년 ${month+1}월 ${i}일 받은 요청 <br>
	 		            				<a data-wf_code="${workflow.wf_code}" id="workflow_info">
		 		            				<div class="calendar_info_workflow">
			 		            				<div style="flex:0.3; text-align:center;">유형 : ${workflow.wf_type} </div>
			 		            				<div style="flex:0.1;"> / </div>
			 		            				<div style="flex:0.6;">제목 : ${workflow.wf_title} </div>
		 		            				</div>
	 		            				</a>
		 		            		</div>
	 		            		</div>
	 		                `	);
	 	            		}
	            		 }
	            	}
	            }
			}
		}
		,error:{
			
		}
	});
}


function showInfoCalendar(flag_show_classes) {
	$(`.${flag_show_classes.split(' ').join('.')}`).css('display', 'block');
}
function hideInfoCalendar(flag_hide_classes) {
	$(`.${flag_hide_classes.split(' ').join('.')}`).css('display', 'none');
}
