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
    
	 // 연도 버튼 클릭 이벤트
	 $('#prevYear').click(function() {
	     currentYear--; // 연도 감소
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 $('#nextYear').click(function() {
	     currentYear++; // 연도 증가
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 // 월 버튼 클릭 이벤트
	 $('#prevMonth').click(function() {
	     currentMonth--; // 월 감소
	     if (currentMonth < 0) {
	         currentMonth = 11; // 12월로 롤오버
	         currentYear--; // 연도 감소
	     }
	     updateCalendar(currentYear, currentMonth);
	 });
	
	 $('#nextMonth').click(function() {
	     currentMonth++; // 월 증가
	     if (currentMonth > 11) {
	         currentMonth = 0; // 1월로 롤오버
	         currentYear++; // 연도 증가
	     }
	     updateCalendar(currentYear, currentMonth);
	 });
}); // docready

const getDay = (stringDate) => {
    if (!stringDate) return '';
    const day = new Date(stringDate);
    return String(day.getDate()).padStart(2, '0');
};


function updateCalendar(year, month) {
	
    // 년도와 월 표시
    $('#year').text(year);
    $('#month').text(month + 1); // 0부터 시작하므로 +1
    $('#day').text(currentDay);

    // 날짜를 초기화
    $('.date').text(''); // 모든 날짜 초기화
    $('.flag').text(''); // 모든 날짜 초기화
    $('.days').removeClass('today');
    $('.days').removeClass('null');

    // 해당 월의 첫 날과 마지막 날
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const daysInMonth = lastDay.getDate(); // 해당 월의 총 일수

    // 첫 날의 요일 (0: 일요일, 1: 월요일, ... 6: 토요일)
    const startDay = firstDay.getDay(); // 첫 번째 날의 요일
    const totalDays = daysInMonth + startDay; // 그리드에 표시할 총 일수
    
    // 날짜를 올바른 위치에 넣기
    for (let i = 1; i <= daysInMonth; i++) {
        // 첫 날의 요일에 맞춰 칸 위치 설정
        const position = startDay + i - 1; 
        $(`#d_${position + 1}`).html(`
                <div class="date">${i}</div>
            `);
    }
    
    $('.days').each(function() {
        if ($(this).find('.date').text().trim() === '') {  // 값이 없을 경우 
            $(this).addClass('null');
        }
    });

    if (year == today.getFullYear() && month == today.getMonth() && currentDay <= daysInMonth) {
        $(`#d_${currentDay + startDay}`).addClass('today');
    }
    
    $.ajax({
		url: '/main/calendar',
		type: 'GET',
		data: {},
		success: function (data) {
			console.log('calendar data :',data)
			
			for (const precense of data.precense) {
				console.log('precense :',getDay(precense.date))
	        }
			
			for (const workflow of data.workflow) {
				console.log('workflow :',workflow)
			}
			
			for (let i = 1; i <= daysInMonth; i++) {
				const flag_position = startDay + i - 1; 
				
	            for(const precense of data.precense){
	            	if(getDay(precense.date) == i){
	            		$(`#d_${flag_position + 1}`).append(`
	            		<div class="flag enter"><i class="fa-solid fa-bookmark"></i></div>
	                `	);
	            	}
	            }
	            
	            for(const precense of data.precense){
	            	if(getDay(precense.date) == i){
	            		if(precense.precense == '출근'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag enter"><i class="fa-solid fa-bookmark"></i></div>
		                `	);
	            		}
	            		if(precense.precense == '휴가'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag leave"><i class="fa-solid fa-bookmark"></i></div>
		                `	);
	            		}
	            		if(precense.precense == '출장'){
		            		$(`#d_${flag_position + 1}`).append(`
		            		<div class="flag workout"><i class="fa-solid fa-bookmark"></i></div>
		                `	);
	            		}
	            	}
	            }
	            
	            
	            
			}
		}
		,error:{
			
		}
	});
}
