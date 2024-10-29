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
	
	console.log('loginAlarm ready');
	
	/* ajax start*/
	$.ajax({
	url: '/main/loginAlarm',
	type: 'GET',
	success: function(data) {
			/* success start*/
			console.log('loginAlarm :',data);
			$('#welcome').text("어서오세요, "+ data.emp_name+" 님!");
			$('#smallAlarm').text(data.smallAlarm);
			
		    if(data.receivedWorkflowList == null){
		    	$('.card-body').append(`
		    			<div 
		    			id="notify" 
		    			style="
		    			height:60px; width:100%; display: flex; align-items: center; justify-content: center; padding:10px;"
		    			>
	            			도착한 요청이 없습니다.
	                	</div>
	                	`);
		    }else{
		    	if(data.receivedWorkflowList.length > 0){  /* received workflow start */
		    		$('#received_workflows').append(`<p>받은 요청</p>`); 
		    		
		    		let receivedWorkflowCount = 0;
			        for (const workflowVO of data.receivedWorkflowList) {
			        	let login_wf_progress = null;
			        	if (workflowVO.wf_progress == '1') {
			        		login_wf_progress = '1차 승인 대기';
						} else if (wf_progress == '2') {
							login_wf_progress = '2차 승인 대기';
						} else if (wf_progress == '3') {
							login_wf_progress = '3차 승인 대기';
						};
			        	 $('#received_workflows').append(`
				            		<div style="display: flex; width:100%; height:80px; background-color:white; box-shadow: 0 2px 2px rgba(0, 0, 0, 0.3); border-radius:5px; margin-bottom:10px;">
			                    		<a data-emp_id="${workflowVO.wf_sender}" class="member_info">
				                    		<div style="display: flex; flex:0.4; padding-right:20px; align-items: center; justify-content: center; border-right: 1px solid rgba(0,0,0,0.1); margin-top:10px; ">
				                    			<div style="display: flex; flex-direction:column; flex:0.4; align-items: center; justify-content: center;">
									        		<div style="flex:1; width:100%; padding:0px 10px;">
										        		<img src="${workflowVO.sender_profile}"
										        		style=" width: 40px; height: 40px; border-radius: 50%;">
									        		</div>
									        	</div>
				                    			<div style="display: flex; flex:0.6; flex-direction:column;">
				                    				<div style="display: flex; width:100%; flex:0.4; font-weight: bold; align-items: center; justify-content: center; padding-bottom:5px;">
				                    					${workflowVO.sender_name}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;" >
				                    					${workflowVO.sender_bnum}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;">
				                    					${workflowVO.sender_dname}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; font-size:12px; align-items: center; justify-content: center;" >
				                    					${workflowVO.sender_position}
				                    				</div>
				                    			</div>
				                    		</div>
			                    		</a>
			                    		<a data-wf_code="${workflowVO.wf_code}" id="workflow_info" style="display: flex; align-items: center; justify-content: center;">
				                    		<div style="display: flex; flex:0.6; flex-direction:column;">
					                    		<div style="display: flex; flex:0.5; width:100%;">
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">유형</div>
				                    					<div style="flex:0.5;">${workflowVO.wf_type}</div>
					                    			</div>
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">상태</div>
				                    					<div style="flex:0.5;">${login_wf_progress}</div>
					                    			</div>
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold; padding-bottom:10px;">수신일</div>
				                    					<div style="flex:0.5;">${getDate(workflowVO.wf_progress === '1' ? workflowVO.wf_create_date : workflowVO.wf_last_result_date)}</div>
					                    			</div>
					                    		</div>
					                    		<div 
					                    		style="display: flex; padding-top:10px; flex:0.5; width:100%; align-items: center; justify-content: center; margin-left:30px; 
					                    		white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width:245px;">
					                    			${workflowVO.wf_title}
					                    		</div>
					                    	</div>
				                    	</a>
			                    	</div>
				            		`); 
			        	 receivedWorkflowCount ++;
			        	 if (receivedWorkflowCount >= 3) {
			        	     break;
			        	 }
		            }
			        if(data.receivedWorkflowList.length > 3){
			        	$('#received_workflows').append(`
			        			<a href="/work/workflow">
				        			<div 
					        			id="notify" 
					        			style="
					        			display: flex; height:60px; align-items: center; justify-content: center;"
				        			>
				        				`+(data.receivedWorkflowList.length-3)+` 개의 받은 요청이 더 있습니다.
				        			</div>
			        			</a>
			        	`); 
			        }
		        } /* received workflow end */
		    } /* workflows end */
	    
        $('#login_alarm_modal').modal('show');
        
        $('#login_alarm_modal').on('shown.bs.modal', function () {
            $(this).focus();
        });
        
		}, /* success end*/
		error: function(xhr, status, error) {
			console.error('AJAX 요청 실패:', status, error);
			console.log('xhr:', xhr);
		} 
	});
	/* ajax end*/
	
});