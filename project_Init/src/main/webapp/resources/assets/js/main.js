$(document).ready(function () {

	$(document).on('click', '#extend_user_setting', function (e) {
		extendUserSetting();
	});
	
	$(document).on('click', '.extend_user_setting', function (e) {
		extendUserSetting();
	});
	
    $(document).on('click', function (e) {
        if (!$(e.target).closest('#user_setting').length 
        		&& !$(e.target).closest('#extend_user_setting').length 
        		&& !$(e.target).closest('.extend_user_setting').length 
        		&& $('#user_setting').css('display') === 'flex')
        {
        	closeUserSetting();
        }
    });

    $(document).on('keydown', function (e) {
        if (e.key === "Escape" && $('#user_setting').css('display') === 'flex') {
    		closeUserSetting();
        }
    });
    
    $(document).on('click', '#update_setting', function (e) {
    	updateUserSetting();
    });
    
    $(document).on('click', '#tool_1', function (e) {
    	$('#tool_selected').val('tool_1');
    	$('#tool_1').addClass('hover');
    	$('#tool_2').removeClass('hover');
    	$('#tool_3').removeClass('hover');
    	$('#tool_4').removeClass('hover');
    });
    
    $(document).on('click', '#tool_2', function (e) {
    	$('#tool_selected').val('tool_2');
    	$('#tool_2').addClass('hover');
    	$('#tool_1').removeClass('hover');
    	$('#tool_3').removeClass('hover');
    	$('#tool_4').removeClass('hover');
    });
    
    $(document).on('click', '#tool_3', function (e) {
    	$('#tool_selected').val('tool_3');
    	$('#tool_3').addClass('hover');
    	$('#tool_1').removeClass('hover');
    	$('#tool_2').removeClass('hover');
    	$('#tool_4').removeClass('hover');
    });
    
    $(document).on('click', '#tool_4', function (e) {
    	$('#tool_selected').val('tool_4');
    	$('#tool_4').addClass('hover');
    	$('#tool_1').removeClass('hover');
    	$('#tool_2').removeClass('hover');
    	$('#tool_3').removeClass('hover');
    });
    
    $(document).on('click', '#search_result', function (e) {
	    	$('#' + $('#tool_selected').val() + ' .tool_name').text($(this).data('tool_name'));
	        $('#' + $('#tool_selected').val()).attr('data-tool_id', $(this).data('tool_id'));
	});
    
    $(document).on('click', '#erase_tool_1', function (e) {
    	$('#tool_1 .tool_name').text('');
    	$('#tool_1').attr('data-tool_id', null);
    });
    $(document).on('click', '#erase_tool_2', function (e) {
    	$('#tool_2 .tool_name').text('');
    	$('#tool_2').attr('data-tool_id', null);
    });
    $(document).on('click', '#erase_tool_3', function (e) {
    	$('#tool_3 .tool_name').text('');
    	$('#tool_3').attr('data-tool_id', null);
    });
    $(document).on('click', '#erase_tool_4', function (e) {
    	$('#tool_4 .tool_name').text('');
    	$('#tool_4').attr('data-tool_id', null);
    });
    
    $(document).on('click', '.tools', function (e) {
    	
    });
    
});

function extendUserSetting() {
	console.log('user_setting form extended!');
	document.getElementById("user_setting").style.animation = 'dropDown 0.5s forwards'; // 페이드인 효과
	document.getElementById("user_setting").style.display = 'flex';
	$('#setting_search_result').empty();
}

function closeUserSetting() {
	console.log('user_setting form closed!');
	document.getElementById("user_setting").style.animation = 'dropUp 0.5s forwards'; // 페이드인 효과
	setTimeout(function() {
		document.getElementById("user_setting").style.display = 'none';
		$('#setting_search_result').empty();
    }, 500); // 애니메이션 시간과 동일하게 설정
}

function updateUserSetting() {
	console.log('tool_id_1:',$('#tool_1').data('tool_id'));
	console.log('tool_id_2:',$('#tool_2').data('tool_id'));
	console.log('tool_id_3:',$('#tool_3').data('tool_id'));
	console.log('tool_id_4:',$('#tool_4').data('tool_id'));
	
	$.ajax({
     url: '/main/updateSetting',
     type: 'GET',
     data: {tool_id_1: $('#tool_1').data('tool_id'),
	        tool_id_2: $('#tool_2').data('tool_id'),
 	        tool_id_3: $('#tool_3').data('tool_id'),
 	        tool_id_4: $('#tool_4').data('tool_id')},
	     success: function (data) {
	    	 closeUserSetting();
	    	 window.location.href = '/main/home';
	     },
	     error: function(xhr, status, error) {
	         console.error('AJAX fail:', status, error);
	         console.log('xhr:', xhr);
	     }
	});
}





let prev_setting_search;

function tool_search(input) {
	const keyword = input.replace(/\s+/g, '');
	$('#tool_search_result').empty();

	if (keyword.length >= 2 && /^[a-zA-Z가-힣0-9]+$/.test(keyword)) {
			if (prev_setting_search) {
				prev_setting_search.abort();
				}
				prev_setting_search = 
					$.ajax({
					url: '/main/toolSearch',
					type: 'GET',
					data: { keyword: keyword },
					success: function (data) {
						console.log('correct value input. start search, result:', data);
						if (data.length === 0) {
							$('#tool_search_result').append(`
					    			<div style="display:flex; height:25px; width:83%; flex-shrink: 0; border-bottom:1px solid rgba(0,0,0,0.1); margin-left:50px;"> 
										"${keyword}" 로 검색한 결과값이 없습니다.
									</div>
						    `);
							}else{
									showResult(data);
							}
						},
						error: function (xhr, status, error) {
							if (status !== 'abort') {
								console.error('AJAX 요청 실패:', status, error);
								console.log('xhr:', xhr);
							}
						}
					}); // ajax end
	}
}

function showResult(data) {
    let count = 0;
    for (const result of data) {
    	$('#tool_search_result').append(`
    			<div id="search_result" data-tool_name = "${result.tool_name}" data-tool_id = "${result.tool_id}" style="display:flex; height:25px; width:83%; flex-shrink: 0; border-bottom:1px solid rgba(0,0,0,0.1); margin-left:50px;"> 
						${result.tool_name}
				</div>
	    `);
    }
}