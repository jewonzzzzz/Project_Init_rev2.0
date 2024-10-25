$(document).ready(function () {
	
	const getDate = (stringDate) => {
	    if (!stringDate) return '';
	    const date = new Date(stringDate);
	    return String(date.getFullYear()).slice(-2) + '.' +
		       String(date.getMonth() + 1).padStart(2, '0') + '.' +
		       String(date.getDate()).padStart(2, '0') + '_' +
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
			$('#welcome').text("welcome, dear "+ data.emp_name);
			$('#smallAlarm').text(data.smallAlarm);
			
		    if(data.receiverWorkflowList == null && data.sentWorkflowList == null){
		    	$('.card-body').append(`
		    			<div 
		    			id="notify" 
		    			style="
		    			height:60px; width:100%; border-bottom:1px solid rgba(0,0,0,0.1); display: flex; align-items: center; justify-content: center; padding:10px;"
		    			>
	            			there is no workflow to notify for you.
	                	</div>
	                	`);
		    }else{
		    	if(data.receivedWorkflowList.length > 0){  /* received workflow start */
		    		$('#received_workflows').append(`<p>RECEIVED WORKFLOWS</p>`); 
		    		
		    		let receivedWorkflowCount = 0;
			        for (const workflowVO of data.receivedWorkflowList) {
			        	 $('#received_workflows').append(`
				            		<div style="display: flex; width:100%; height:100px; border-bottom:1px solid rgba(0,0,0,0.1);">
			                    		<a data-emp_id="${workflowVO.wf_sender}"  class="member_info">
				                    		<div style="display: flex; flex:0.4; align-items: center; justify-content: center; border-right: 1px solid rgba(0,0,0,0.1); margin:15px 0px 15px 0px; ">
				                    			<div style="display: flex; flex-direction:column; flex:0.4; align-items: center; justify-content: center;">
				                    				<div style="flex:0.2; font-weight: bold width:100%;" >sender</div>
									        		<div style="flex:0.8; width:100%;">
										        		<img src="${workflowVO.sender_profile}"
										        		style=" width: 40px; height: 40px; border-radius: 50%;">
									        		</div>
									        	</div>
				                    			<div style="display: flex; flex:0.6; flex-direction:column;">
				                    				<div style="display: flex; width:100%; flex:0.4; font-weight: bold; align-items: center; justify-content: center;">
				                    					${workflowVO.sender_name}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;" >
				                    					${workflowVO.sender_bnum}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;">
				                    					${workflowVO.sender_dnum}
				                    				</div>
				                    				<div style="display: flex; width:100%; flex:0.2; align-items: center; justify-content: center;" >
				                    					${workflowVO.sender_position}
				                    				</div>
				                    			</div>
				                    		</div>
			                    		</a>
			                    		<a data-wf_code="${workflowVO.wf_code}" id="workflow_info">
				                    		<div style="display: flex; flex:0.6; flex-direction:column;">
					                    		<div style="display: flex; flex:0.5; width:100%;">
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold">type</div>
				                    					<div style="flex:0.5;">${workflowVO.wf_type}</div>
					                    			</div>
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold">progress</div>
				                    					<div style="flex:0.5;">${workflowVO.wf_progress}</div>
					                    			</div>
					                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
					                    				<div style="flex:0.5; font-weight: bold">date</div>
				                    					<div style="flex:0.5;">${getDate(workflowVO.wf_progress === '1' ? workflowVO.wf_create_date : workflowVO.wf_last_result_date)}</div>
					                    			</div>
					                    		</div>
					                    		<div 
					                    		style="display: flex; flex:0.5; width:100%; align-items: center; justify-content: left; margin-left:30px; 
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
					        			display: flex; height:60px; border-bottom:1px solid rgba(0,0,0,0.1); align-items: center; justify-content: center;"
				        			>
				        				there is more `+(data.receivedWorkflowList.length-3)+` received workflow to notify for you.
				        			</div>
			        			</a>
			        	`); 
			        }
		        } /* received workflow end */
		        if(data.sentWorkflowList.length > 0){   /* sent workflow end */
		        	
			    	$('#sent_workflows').append(`<p>COMPLETED WORKFLOWS</p>`); 
			    	
			    	let sentWorkflowCount = 0;
			        for (const workflowVO of data.sentWorkflowList) {
			        	$('#sent_workflows').append(`
			            		<div style="display: flex; width:100%; height:100px; border-bottom:1px solid rgba(0,0,0,0.1);">
		                    		<a data-emp_id="${workflowVO.wf_code}" id="workflow_info">
			                    		<div style="display: flex; flex-direction:column; flex:0.5; align-items: center; justify-content: center; border-right: 1px solid rgba(0,0,0,0.1); margin:15px 0px 15px 0px; ">
		                    				<div style="display: flex; flex:0.5; width:100%;">
				                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
				                    				<div style="flex:0.5 width:100%; ; font-weight: bold">type</div>
			                    					<div style="flex:0.5 width:100%; ;">${workflowVO.wf_type}</div>
				                    			</div>
				                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
				                    				<div style="flex:0.5 width:100%; ; font-weight: bold">progress</div>
			                    					<div style="flex:0.5 width:100%; ;">${workflowVO.wf_progress}</div>
				                    			</div>
				                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
				                    				<div style="flex:0.5 width:100%; ; font-weight: bold">date</div>
			                    					<div style="flex:0.5 width:100%; ;">${getDate(workflowVO.wf_progress === '1' ? workflowVO.wf_create_date : workflowVO.wf_last_result_date)}</div>
				                    			</div>
				                    		</div>
				                    		<div 
				                    		style="display: flex; flex:0.5; align-items: center; justify-content: left; margin-left:30px; 
				                    		white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width:100%; ">
				                    			${workflowVO.wf_title}
				                    		</div>
			                    		</div>
		                    		</a>
		                    		<div style="display: flex; flex:0.5;">
		                    			<a data-emp_id="${workflowVO.wf_receiver_1st}" class="member_info">
			                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
			                    				<div style="flex:0.4 width:100%; ; font-weight: bold">1st_result</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.wf_result_1st}</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.receiver_name_1st}</div>
			                    			</div>
		                    			</a>
		                    			<a data-emp_id="${workflowVO.wf_receiver_2nd}" class="member_info">
			                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
			                    				<div style="flex:0.4 width:100%; ; font-weight: bold">2nd_result</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.wf_result_2nd}</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.receiver_name_2nd}</div>
			                    			</div>
		                    			</a>
		                    			<a data-emp_id="${workflowVO.wf_receiver_3rd}" class="member_info">
			                    			<div style="flex:1; display: flex; flex-direction:column; align-items: center; justify-content: center;">
			                    				<div style="flex:0.4 width:100%; ; font-weight: bold">3rd_result</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.wf_result_3rd}</div>
		                    					<div style="flex:0.3 width:100%; ;">${workflowVO.receiver_name_3rd}</div>
			                    			</div>
		                    			</a>
			                    	</div>
		                    	</div>
			            		`); 
			        	sentWorkflowCount ++;
		        	    if (sentWorkflowCount >= 3) {
		        	        break;
		        	    }
				    }
			        if(data.sentWorkflowList.length > 3){
			        	$('#sent_workflows').append(`
			        			<a href="/work/workflow">
				        			<div 
					        			id="notify" 
					        			style="
					        			display: flex; height:60px; border-bottom:1px solid rgba(0,0,0,0.1); align-items: center; justify-content: center;"
				        			>
				        				there is more `+(data.sentWorkflowList.length-3)+` copleted workflow that you sent.
				        			</div>
			        			</a>
			        	`); 
			        }
		        } /* sent workflow end */
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