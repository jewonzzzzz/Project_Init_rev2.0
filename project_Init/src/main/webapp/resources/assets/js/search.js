$(document).ready(function () {

	$(document).on('click', '#search_form', function (e) {
		if ($('#search_form_extended').css('display') === 'none') {
	        $('#search_notify').css('display', 'block');
	    }
		extendSearchForm();
	});
	
    $(document).on('click', function (e) {
        if (!$(e.target).closest('#search_form').length 
        		&& !$(e.target).closest('#search_form_extended').length 
        		&& !$(e.target).closest('.modal').length
        		&& $('#search_form_extended').css('display') === 'block') 
        {
        	closeSearchForm();
        }
    });

    $(document).on('keydown', function (e) {
        if (e.key === "Escape") {
        		closeSearchForm()
        }
    });
});

/*
function checkModal() {
	const openModals = $('.modal.show');
	if (openModals.length > 0) {
	    console.log("there is open modal :",openModals.length);
	    openModals.each(function() {
	        console.log($(this).attr('id'));
	    });
	}else{
		console.log("there is no open modal");
	}
	console.log(openModals.length);
}
*/

function extendSearchForm() {
	console.log('search form extended!');
	document.getElementById("search_form_extended").style.animation = 'dropDown 0.5s forwards'; // 페이드인 효과
	document.getElementById("search_form_extended").style.display = 'block';
    $('#search_form').addClass('focus_border');
}

function closeSearchForm() {
    console.log('search form closed.');
    document.getElementById("search_form_extended").style.animation = 'dropUp 0.5s forwards'; // 드롭업 애니메이션
    setTimeout(function() {
        document.getElementById("search_form_extended").style.display = 'none'; // 애니메이션 후 숨김
    }, 500); // 애니메이션 시간과 동일하게 설정
    $('#searchInput').val('');
    $('#search_employees').empty();
    $('#search_notify').css('display', 'none');
    $('#search_null').css('display', 'none');
    $('#search_incorrect').css('display', 'none');
    $('#search_form').removeClass('focus_border');
}

let prev;

function search(input) {
	const keyword = input.replace(/\s+/g, '');
	$('#search_employees').empty();

	if (keyword.length >= 2 && /^[a-zA-Z가-힣0-9]+$/.test(keyword)) {
			if (prev) {
				prev.abort();
				}
				prev = 
					$.ajax({
					url: '/main/search',
					type: 'GET',
					data: { keyword: keyword },
					success: function (data) {
						console.log('correct value input. start search, result:', data);
						if (data.length === 0) {
							$('#search_notify').css('display', 'none');
							$('#search_null li').text('"' + keyword + '" 로 검색한 결과값이 없습니다.');
							$('#search_null').css('display', 'block');
							$('#search_incorrect').css('display', 'none');
						}else{
							findSuccess(data);
						}
					},
					error: function (xhr, status, error) {
						if (status !== 'abort') {
							console.error('AJAX 요청 실패:', status, error);
							console.log('xhr:', xhr);
						}
					}
				}); // ajax end
	} else {
		if(keyword.length < 2){
			$('#search_notify').css('display', 'block');
			$('#search_null').css('display', 'none');
			$('#search_incorrect').css('display', 'none');
		}
		if(keyword.length > 2){
			$('#search_notify').css('display', 'none');
			$('#search_null').css('display', 'none');
			$('#search_incorrect').css('display', 'block');
		}
	}
}

function findSuccess(data) {
	$('#search_null').css('display', 'none');
    $('#search_notify').css('display', 'none');
    $('#search_incorrect').css('display', 'none');
	showEmployees(data);
}

function showEmployees(data) {
    let count = 0;
    for (const memberVO of data) {
    	$('#search_employees').append(`
    			<li>
					<a class="member_info" data-emp_id="${memberVO.emp_id}">
	                	<div style="display: flex; height:100px; padding: 0px 50px;">
	                		<div style="display: flex; flex:0.2; align-items: center; justify-content: center;">
	                			<img src="${memberVO.emp_profile}"
					        	style="width: 60px; height: 60px; border-radius: 50%;">
	                		</div>
	                		<div style="flex:0.3; display: flex; flex-direction:column; margin-left:10px;">
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; flex-direction:column; align-items: center; justify-content: flex-end;">
	                				${memberVO.emp_position}
	                			</div>
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; flex-direction:column; align-items: center; justify-content: flex-start;">
	                				${memberVO.emp_name}
	                    		</div>
	                		</div>
	                		<div style="flex:0.2; display: flex; flex-direction:column; margin-left:10px;">
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; align-items: center; justify-content: center;">
	                				${memberVO.emp_bnum}
	                			</div>
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; align-items: center; justify-content: center;">
	                				${memberVO.emp_dnum}
	                    		</div>
	                    		<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; align-items: center; justify-content: center;">
	                    			${memberVO.emp_job}
	                    		</div>
	                		</div>
	                		<div style="flex:0.3; display: flex; flex-direction:column; margin-left:10px;">
	                			${memberVO.emp_power != null ? `
		                            <div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; flex-direction:column; align-items: center; justify-content: center">
		                                ${memberVO.emp_power}
		                            </div>
		                        ` : ''}
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; flex-direction:column; align-items: center; justify-content: flex-end;">
	                				${memberVO.emp_tel}
	                			</div>
	                			<div style="flex:1; color: rgba(0, 0, 0, 0.7); display: flex; flex-direction:column; align-items: center; justify-content: flex-start;">
	                				${memberVO.emp_email}
	                    		</div>
	                		</div>
	                 	</div>
	            	</a>
				</li>
	    `);
	    
    	console.log('employees count : '+(count+1));
		count ++;
	    if (count >= 5) {
	        $('#search_employees').append(`
	        		<li>There is more ${(data.length)-5} employees. check here.</li>
		    `);
	        break;
	    }
    }
}
	
