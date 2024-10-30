
$(document).ready(function () {
	
	const getDate = (stringDate) => {
	    if (!stringDate) return '';
	    const date = new Date(stringDate);
	    return String(date.getFullYear()).slice(-2) + '.' +
		       String(date.getMonth() + 1).padStart(2, '0') + '.' +
		       String(date.getDate()).padStart(2, '0') + '  ' +
		       String(date.getHours()).padStart(2, '0') + ':' +
		       String(date.getMinutes()).padStart(2, '0');
	};
	
	var workflowVO;
	
	$(document).on('click', '#workflow_info', function (e) {
		
		var wf_code = $(this).data('wf_code');
	    
	    console.trace();
	    console.log('workflow_modal is opened.');
	    console.log('AJAX requested for wf_code :', wf_code); // wf_code 값 출력
		
		$.ajax({
			url: '/work/readWorkflow',
			type: 'GET',
			data: {wf_code: wf_code},
			success: function (data) {
				console.log('AJAX success for wf_code :', wf_code);
				console.log('taken data:', data);
				
				workflowVO = data.workflowVO;
		    	
				/* value to next page start */
				$('#resp_wf_code').val(workflowVO.wf_code);
				$('#resp_wf_type').val(workflowVO.wf_type);
				$('#resp_wf_target').val(workflowVO.wf_target);
				$('#resp_wf_progress').val(workflowVO.wf_progress);
				$('#resp_wf_receiver_2nd').val(workflowVO.wf_receiver_2nd);
				$('#resp_wf_receiver_3rd').val(workflowVO.wf_receiver_3rd);
				$('#a_sender').attr('data-emp_id', workflowVO.wf_sender);
				$('#a_receiver').attr('data-emp_id', workflowVO.wf_receiver);
				$('#a_receiver_1st').attr('data-emp_id', workflowVO.wf_receiver_1st);
				/* value to next page end */
				
				/* set text in page start */
					
				/* set workflow basic info start*/
				$('#wf_code').text(wf_code);
				$('#wf_type').text(workflowVO.wf_type);
				$('#wf_title').text(workflowVO.wf_title);
				$('#wf_file').text(workflowVO.wf_file);
				
				if (workflowVO.wf_status == '1') {
				 	$('#wf_status').text('진행 중');
				} else if (workflowVO.wf_status == '0') {
					$('#wf_status').text('완료');
				};
				
				if (workflowVO.wf_progress == '1') {
				 	$('#wf_progress').text('1차 승인 대기');
				} else if (workflowVO.wf_progress == '2') {
					$('#wf_progress').text('2차 승인 대기');
				} else if (workflowVO.wf_progress == '3') {
					$('#wf_progress').text('3차 승인 대기');
				};
					
				$('#wf_create_date').text(getDate(workflowVO.wf_create_date));
				$('#wf_content').text(workflowVO.wf_content);
				$('#wf_sender_emp_name').text(workflowVO.sender_name);
				$('#wf_sender_emp_dname').text(workflowVO.sender_dname);
				$('#wf_sender_emp_position').text(workflowVO.sender_position);
				$('#wf_receiver_emp_name').text(workflowVO.receiver_name);
				$('#wf_receiver_emp_dname').text(workflowVO.receiver_dname);
				$('#wf_receiver_emp_position').text(workflowVO.receiver_position);
				$('#wf_receiver_1st_emp_name').text(workflowVO.receiver_name_1st);
				$('#wf_receiver_1st_emp_dname').text(workflowVO.receiver_dname_1st);
				$('#wf_receiver_1st_emp_position').text(workflowVO.receiver_position_1st);
				/* set workflow basic info end*/
				
				/* set receivers start */
				if (workflowVO.receiver_name_2nd != null) {
					$('#receivers').append(`
						<div id="receiver_2nd" class="form-group" style="height:100px; display: flex; flex-direction:column; ">
		                	<div style="flex:0.2;">
		                		2차 승인자
		                	</div>
		                	<a data-emp_id="${workflowVO.wf_receiver_2nd}" class="member_info">
		                   	<div style="flex:0.8; display: flex; color: rgba(0, 0, 0, 0.7);">
		                   		<div style="display: flex; flex:0.2; align-items: center; justify-content: center;">
		                   			<img src="${workflowVO.receiver_profile_2nd}"
							        	style="width: 40px; height: 40px; border-radius: 50%;">
		                   		</div>
		                   		<div style="flex:0.4; display: flex; flex-direction:column;">
		                   			<div style="flex:0.4; font-weight: bold; color: black;">
		                   				${workflowVO.receiver_name_2nd}
		                   			</div>
		                   			<div style="flex:0.3;" >
		                   				${workflowVO.receiver_dname_2nd}
		                    		</div>
		                    		<div style="flex:0.3;" >
		                    			${workflowVO.receiver_position_2nd}
		                    		</div>
		                   		</div>
		                   		<div style="flex:0.4; display: flex; flex-direction:column; align-items: center; justify-content: center;">
		                   			<div style="flex:0.7; display: flex; align-items: center; justify-content: center;" id="wf_result_2nd">
		                   			</div>
		                   			<div style="flex:0.3; display: flex; align-items: center; justify-content: center;" id="wf_result_date_2nd">
		                   			</div>
		                   		</div>
		                    	</div>
		                    </a>
		                </div>
                    `);
				}
				
				if (workflowVO.receiver_name_3rd != null) {
					$('#receivers').append(`
						<div id="receiver_3rd" class="form-group" style="height:100px; display: flex; flex-direction:column; ">
		                	<div style="flex:0.2;">
		                		3차 승인자
		                	</div>
		                	<a data-emp_id="${workflowVO.wf_receiver_3rd}" class="member_info">
		                   	<div style="flex:0.8; display: flex; color: rgba(0, 0, 0, 0.7);">
		                   		<div style="display: flex; flex:0.2; align-items: center; justify-content: center;">
		                   			<img src="${workflowVO.receiver_profile_3rd}"
							        	style="width: 40px; height: 40px; border-radius: 50%;">
		                   		</div>
		                   		<div style="flex:0.4; display: flex; flex-direction:column;">
		                   			<div style="flex:0.4; font-weight: bold; color: black;">
		                   				${workflowVO.receiver_name_3rd}
		                   			</div>
		                   			<div style="flex:0.3;">
		                   				${workflowVO.receiver_dname_3rd}
		                    		</div>
		                    		<div style="flex:0.3;">
		                    			${workflowVO.receiver_position_3rd}
		                    		</div>
		                   		</div>
		                   		<div style="flex:0.4; display: flex; flex-direction:column; align-items: center; justify-content: center;">
		                   			<div style="flex:0.7; display: flex; align-items: center; justify-content: center;" id="wf_result_3rd">
		                   			</div>
		                   			<div style="flex:0.3; display: flex; align-items: center; justify-content: center;" id="wf_result_date_3rd">
		                   			</div>
		                   		</div>
		                    	</div>
		                    </a>
		                </div>
                    `);
				}
				/* set receivers end */
				
				/* set result start */
				if(workflowVO.wf_result_1st != null){
					
					let wf_modal_result_1st = null;
					if(workflowVO.wf_result_1st == '1'){
						wf_modal_result_1st = '승인';
					}
					if(workflowVO.wf_result_1st == '0'){
						wf_modal_result_1st = '반려';
					}
					if(workflowVO.wf_result_1st == '2'){
						wf_modal_result_1st = '보류';
					}
					
					$('#wf_result_1st').text(wf_modal_result_1st);
					$('#wf_result_date_1st').text(getDate(workflowVO.wf_result_date_1st));
				}
				
				if(workflowVO.wf_result_2nd != null){
					
					let wf_modal_result_2nd = null;
					if(workflowVO.wf_result_2nd == '1'){
						wf_modal_result_2nd = '승인';
					}
					if(workflowVO.wf_result_2nd == '0'){
						wf_modal_result_2nd = '반려';
					}
					if(workflowVO.wf_result_2nd == '2'){
						wf_modal_result_2nd = '보류';
					}
					
					$('#wf_result_2nd').text(wf_modal_result_2nd);
					$('#wf_result_date_2nd').text(getDate(workflowVO.wf_result_date_2nd));
				}
				
				if(workflowVO.wf_result_3rd != null){
					
					let wf_modal_result_3rd = null;
					if(workflowVO.wf_result_3rd == '1'){
						wf_modal_result_3rd = '승인';
					}
					if(workflowVO.wf_result_3rd == '0'){
						wf_modal_result_3rd = '반려';
					}
					if(workflowVO.wf_result_3rd == '2'){
						wf_modal_result_3rd = '보류';
					}

					$('#wf_result_3rd').text(wf_modal_result_3rd);
		            $('#wf_result_date_3rd').text(getDate(workflowVO.wf_result_date_3rd));
				}
				/* set result end */
				
	            /* set comment start */
	            function appendComment(receiver_name, receiver_profile, comment, result_date, receiver_id) {
	                if (comment != null) {
	                    $('#commentSection').append(`
	                        <a data-emp_id="${receiver_id}" class="member_info">
	                            <div style="width: 100%; height: auto; flex-grow: 1; display: flex;">
	                                <div style="width: 5%; display: flex; align-items: center; justify-content: center; padding-right:40px;">
	                                    <img src="${receiver_profile}" alt="img" style="width: 40px; height: 40px; border-radius: 50%;">
	                                </div>
	                                <div style="width: 95%; height: auto; display: flex; flex-direction: column; padding: 5px;">
	                                    <div style="flex: 0.3; font-weight: bold; color: black;">
	                                        ${receiver_name}
	                                    </div>
	                                    <div style="flex: 0.7; display: flex;">
	                                        <div style="flex: 0.9; max-width: 90%; overflow-wrap: break-word; color: rgba(0, 0, 0, 0.7);">
	                                            ${comment}
	                                        </div>
	                                        <div style="flex: 0.1; color: rgba(0, 0, 0, 0.5); display: flex; align-items: flex-end; justify-content: flex-end;">
	                                            ${getDate(result_date)}
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </a>
	                    `);
	                } else {
	                    console.log('No comment available');
	                }
	            }
	            appendComment(workflowVO.receiver_name_1st, workflowVO.receiver_profile_1st, workflowVO.wf_comment_1st, workflowVO.wf_result_date_1st, workflowVO.wf_receiver_1st);
		        appendComment(workflowVO.receiver_name_2nd, workflowVO.receiver_profile_2nd, workflowVO.wf_comment_2nd, workflowVO.wf_result_date_2nd, workflowVO.wf_receiver_2nd);
		        appendComment(workflowVO.receiver_name_3rd, workflowVO.receiver_profile_3rd, workflowVO.wf_comment_3rd, workflowVO.wf_result_date_3rd, workflowVO.wf_receiver_3rd);
		        /* set comment end */
		        
		        /* modify form as status start*/
		        const div_card = document.querySelector('.card'); 
		        const div_select = document.querySelector('#select_result'); 
		        const div_approval = document.querySelector('#approval'); 
		        const div_reject = document.querySelector('#reject'); 
		        const div_hold = document.querySelector('#hold'); 
		        const div_submit = document.querySelector('#submit_button'); 
		        const textarea_comment = document.querySelector('#resp_wf_comment'); 
		        
	    		if(workflowVO.wf_status == '0'){
	    			
		    		div_card.style.backgroundColor = 'rgb(200,200,200)';
		    	    textarea_comment.value = '해당 요청은  '+ getDate(workflowVO.wf_result_date) +'  에 종료 되었습니다.';
		    	    textarea_comment.readOnly = true;
		    	    div_submit.style.display='none';
		    	    div_approval.style.display='block';
	    	    	div_reject.style.display='block';
	    	    	div_hold.style.display='block';
		    	    
		    	    if(workflowVO.wf_result == '1'){
		    	    	div_reject.style.display='none';
		    	    	div_hold.style.display='none';
		    	    }
		    	    if(workflowVO.wf_result == '0'){
		    	    	div_approval.style.display='none';
		    	    	div_hold.style.display='none';
		    	    }
		    	    if(workflowVO.wf_result == '2'){
		    	    	div_approval.style.display='none';
		    	    	div_reject.style.display='none';
		    	    }
	    		};
	    		
	    		if(workflowVO.wf_status == '1'){
	    			if (data.logined_id == workflowVO.wf_receiver) {
	    				div_card.style.backgroundColor = '#fff';
	    		    	textarea_comment.value = '';
	    		    	textarea_comment.removeAttribute('readonly');
	    		    	textarea_comment.style.paddingTop = '0';
	    		    	div_select.style.display='block';
	    		    	div_submit.style.display='block';
	    		    	div_approval.style.display='block';
		    	    	div_reject.style.display='block';
		    	    	div_hold.style.display='block';
	    			}else{
	    				console.log('but receiver isnt me');
	    				div_select.style.display='none';
		    	    	div_submit.style.display='none';
	    				textarea_comment.value = '해당 요청의 현재 담당자가 아닙니다.';
			    	    textarea_comment.readOnly = true;
			    	    textarea_comment.style.paddingTop = '60px';
	    			}
		    	};
	    		/* modify form as status end*/
	    		
	    		$('#workflow_modal').modal('show');
	    		$('#workflow_modal').on('shown.bs.modal', function () {
	                $(this).focus();
	            });
			},
			error: function(xhr, status, error) {
				console.error('AJAX 요청 실패:', status, error);
				console.log('xhr:', xhr);
			}
		});
	});
	
	$('#wfresp_button').off('click').on('click', function(e) {
        e.preventDefault();
        var result = $('input[name="wf_result"]:checked').val();
    	
    	if (!result) {
    	        e.preventDefault();
    	        swal("Error!", "승인 여부를 확인하세요." , "error");
	    }else{
	        if (result === "1") {
	        	swal({
                    title: "Success!",
                    text: "해당 요청을 승인 처리하였습니다.",
                    icon: "success",
                    button: "OK"
                }).then(function() {
                	$('#workflow_response_submit').submit();
                });
	        } else if (result === "0") {
	        	swal({
                    title: "Success!",
                    text: "해당 요청을 반려 처리하였습니다.",
                    icon: "success",
                    button: "OK"
                }).then(function() {
                	$('#workflow_response_submit').submit();
                });
	        } else if (result === "2") {
	        	swal({
                    title: "Success!",
                    text: "해당 요청을 보류 처리하였습니다.",
                    icon: "success",
                    button: "OK"
                }).then(function() {
                	$('#workflow_response_submit').submit();
                });
	        }
	    }
    });
	
	$('#workflow_modal').off('hidden.bs.modal').on('hidden.bs.modal', function (e) {
    	console.log('workflow_modal is closed.');
        $('#commentSection').empty();
        $('#receiver_2nd').remove();
        $('#receiver_3rd').remove();
	});
	
});

	
	


