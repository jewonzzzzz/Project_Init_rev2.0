<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="${pageContext.request.contextPath }/resources/assets/js/workflow_infobox.js"></script>

<!-- workflow_modal modal start-->
<div class="modal fade" id="workflow_modal" tabindex="0" aria-labelledby="wfDetail" aria-hidden="true" style="z-index: 1060;">
	<div class="modal-dialog modal-xl">
		<!-- modal content start -->
		<div class="modal-content" style="background-color: rgba(0,0,0,0.3);">
			<!-- modal body start -->
			<div class="modal-body">
				<div class="row">
					<div class="col-md-12">
						<div class="card" style="margin:0;">
							<div class="card-header" style="display:flex;" >
								<div class="card-title" style="flex:99;">워크플로우 상세보기</div>
								<div style="flex:1;">
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
							</div>
							<!-- card body start -->
							<div class="card-body">
								<form id="workflow_response_submit" action="/work/wfresponse" method="POST">
									<input type="hidden" id="resp_wf_code" name="wf_code" value=""/>
									<input type="hidden" id="resp_wf_type" name="wf_type" value=""/>
									<input type="hidden" id="resp_wf_target" name="wf_target" value=""/>
									<input type="hidden" id="resp_wf_progress" name="wf_progress" value=""/>
									<input type="hidden" id="resp_wf_receiver_2nd" name="wf_receiver_2nd" value=""/>
									<input type="hidden" id="resp_wf_receiver_3rd" name="wf_receiver_3rd" value=""/>
									<div class="row">
					                    <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1); display:flex; flex-direction: column; justify-content: center; align-content: center;">
								                <label class="control-label"> 유형 </label>
								                <p id="wf_type" class="form-control-static"></p>
					                    </div>
					                    <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1); display:flex; flex-direction: column; justify-content: center; align-content: center;">
								                <label class="control-label"> 상태 </label>
								                <p id="wf_status" class="form-control-static"></p>
					                    </div>
					                     <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1); display:flex; flex-direction: column; justify-content: center; align-content: center;">
								                <label class="control-label"> 상세 </label>
								                <p id="wf_progress" class="form-control-static"></p>
					                    </div>
					                    <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1); display:flex; flex-direction: column; justify-content: center; align-content: center;">
								                <label class="control-label"> 생성일 </label>
								                <p id="wf_create_date" class="form-control-static"></p>
					                    </div>
					                     <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1);">
											<div class="form-group" style="text-align: center;">
								                <label class="control-label"> 발신자 </label>
								                <a id="a_sender" class="member_info" data-emp_id="">
									                <div class="form-group" style="height:80px; display: flex;">
								                    	<div style="display: flex; ">
								                    		<div style="display: flex; flex:0.3; align-items: center; justify-content: center;">
								                    			<img id="wf_sender_profile" src=""
													        	style="width: 40px; height: 40px; border-radius: 50%;">
								                    		</div>
								                    		<div style="flex:0.7; display: flex; flex-direction:column; margin-left:10px;">
								                    			<div style="flex:0.3; font-weight: bold; color: black;" id="wf_sender_emp_name">
								                    			</div>
								                    			<div style="flex:0.3; color: rgba(0, 0, 0, 0.7);" id="wf_sender_emp_dname">
									                    		</div>
									                    		<div style="flex:0.3; color: rgba(0, 0, 0, 0.7);" id="wf_sender_emp_position">
									                    		</div>
								                    		</div>
								                     	</div>
								                    </div>
							                    </a>
						                    </div>
					                    </div>
					                    <div class="col-md-6 col-lg-2" style="border-bottom: 1px solid rgba(0,0,0,0.1);">
											<div class="form-group">
								                <label class="control-label"> 수신자 </label>
								                <a id="a_receiver" class="member_info" data-emp_id="">
								            		<div class="form-group" style="height:80px; display: flex;">
								                    	<div style="display: flex; ">
								                    		<div style="display: flex; flex:0.3; align-items: center; justify-content: center;">
								                    			<img id="wf_receiver_profile" src=""
													        	style="width: 40px; height: 40px; border-radius: 50%;">
								                    		</div>
								                    		<div style="flex:0.7; display: flex; flex-direction:column; margin-left:10px;">
								                    			<div style="flex:0.3; font-weight: bold; color: black;" id="wf_receiver_emp_name">
								                    			</div>
								                    			<div style="flex:0.3; color: rgba(0, 0, 0, 0.7);" id="wf_receiver_emp_dname">
									                    		</div>
									                    		<div style="flex:0.3; color: rgba(0, 0, 0, 0.7);" id="wf_receiver_emp_position">
									                    		</div>
								                    		</div>
								                     	</div>
								                    </div>
								            	</a>
						                    </div>
					                    </div>
									</div>
									<div class="row">
										 <div class="col-md-6 col-lg-8">
											<div class="form-group">
								                <label class="control-label"> 제목 </label>
								                <p id="wf_title" class="form-control-static"></p>
						                    </div>
						                    <div class="form-group">
						                        <div class="input-group" style="height: 400px;">
							                        <span 
								                        class="input-group-text" 
								                        style="writing-mode: vertical-lr; text-orientation: upright;">
							                       		본문
							                        </span>
							                        <textarea
							                        id="wf_content"
							                        class="form-control"
							                        aria-label="With textarea"
							                        readonly
							                        style= "background-color: white !important;">
							                        </textarea>
						                         </div>
					                        </div>
						                    <div class="form-group">
								                <label class="control-label"> 첨부파일 </label>
								                <p id="wf_file" class="form-control-static"></p>
						                    </div>
					                    </div>
					                    <div class="col-md-6 col-lg-4" style="display: flex; flex-direction:column;">
					                    	<div id="receivers" style="display:flex; flex-direction:column; flex:0.5; justify-content: center;">
						                    	 <!-- 1ì°¨ì¹ì¸ì start -->
							                     <div class="form-group" style="height:100px; display: flex; flex-direction:column; ">
							                     	<div style="flex:0.2;">
							                     		1차 승인자
							                     	</div>
							                     	<a id="a_receiver_1st" class="member_info" data-emp_id="">
								                    	<div style="flex:0.8; display: flex; color: rgba(0, 0, 0, 0.7);">
								                    		<div style="display: flex; flex:0.2; align-items: center; justify-content: center;">
								                    			<img id="wf_receiver_profile_1st" src=""
													        	style="width: 40px; height: 40px; border-radius: 50%;">
								                    		</div>
								                    		<div style="flex:0.4; display: flex; flex-direction:column;">
								                    			<div style="flex:0.4; font-weight: bold; color: black;" id="wf_receiver_1st_emp_name">
								                    			</div>
								                    			<div style="flex:0.3;" id="wf_receiver_1st_emp_dname">
									                    		</div>
									                    		<div style="flex:0.3;" id="wf_receiver_1st_emp_position">
									                    		</div>
								                    		</div>
								                    		<div style="flex:0.4; display: flex; flex-direction:column; align-items: center; justify-content: center;">
								                    			<div style="flex:0.7; display: flex; align-items: center; justify-content: center;" id="wf_result_1st">
								                    			</div>
								                    			<div style="flex:0.3; display: flex; align-items: center; justify-content: center;" id="wf_result_date_1st">
								                    			</div>
								                    		</div>
								                     	</div>
								                     </a>
							                     </div>
							                     <!-- 1ì°¨ì¹ì¸ì end -->
							                 </div>
							                 <div style="flex:0.5;">
							                     <div class="form-group">
							                         <label for="comment">Comment</label>
							                         <textarea class="form-control" id="resp_wf_comment" rows="5" name="wf_comment"></textarea>
						                         </div>
						                         <div class="form-group" id="select_result">
													 <label class="form-label">승인 결과</label>
													 <div class="selectgroup w-100">
													 	<label class="selectgroup-item" id="approval">
															<input
															   type="radio"
															   name="wf_result"
															   value="1"
															   class="selectgroup-input"
															 />
															<span class="selectgroup-button selectgroup-button-icon">
								                         		<i class="fas fa-check"></i>
															</span>
														</label>
														<label class="selectgroup-item" id="reject">
															<input
															   type="radio"
															   name="wf_result"
															   value="0"
															   class="selectgroup-input"
															 />
															<span class="selectgroup-button selectgroup-button-icon">
																<i class="fas fa-ban"></i>
															</span>
														</label>
														<label class="selectgroup-item" id="hold">
															<input
															   type="radio"
															   name="wf_result"
															   value="2"
															   class="selectgroup-input"
															 />
															<span class="selectgroup-button selectgroup-button-icon">
																<i class="fas fa-redo"></i>
															</span>
														</label>
													 </div>
												 </div>
												 
												 <div class="form-group" id="submit_button">
							                         <div class="input-group">
								                         <button
								                         id="wfresp_button"
								                         class="custom_button"
								                         type="submit"
								                         style="width:100%;"
								                         >
								               			   제출
								                         </button>
							                         </div>
						                         </div>
						                    </div>
					                    </div>
									</div>
								</form>
							</div>
							<!-- card-body end -->
							<div class="card-action" id="commentSection">
							</div>
					   </div>
					   <!-- card end -->
					</div> 
				</div> 
			</div>
		</div>
		<!-- modal content end -->
	</div>
</div>
<!-- workflow_modal modal end-->
