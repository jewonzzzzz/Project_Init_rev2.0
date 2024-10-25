<script src="${pageContext.request.contextPath }/resources/assets/js/member_infobox.js"></script>

<!-- get_employee_info modal start -->
<div class="modal fade" id="get_employee_info" tabindex="1" aria-labelledby="memberDetail" aria-hidden="true" style=" z-index: 1070; background-color: rgba(0,0,0,0.5);">
	<div class="modal-dialog modal-md" >
		<!-- modal content start -->
		<div class="modal-content" style="background-color: rgba(0,0,0,0.3);">
			<!-- modal body start -->
			<div class="modal-body">
				<div class="card" style="margin:0px; display:flex; flex-direction: column;">
					<div style="display:flex; background-color: rgba(0,0,0,0.1); flex:1; justify-content: flex-end; padding:10px;">
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<!-- card body start -->
					<div class="card-body" style="background-color: rgba(0,0,0,0.1); flex:99">
						<form action="" method="POST">
							<div class="form-group" style= "display: flex; height: 400px; flex-direction:column;">
								<div style="display: flex; flex:0.5;">
		                    		<div style="display: flex; flex:0.5; align-items: center; justify-content: center;">
		                    			<img src=""
							        	style="width: 100px; height: 100px; border-radius: 50%;">
		                    		</div>
		                    		<div style="flex:0.5; display: flex; flex-direction:column;">
		                    			<div style="flex:0.2; font-weight: bold; color: black;" id="emp_name">
		                    				<input type="hidden" id="emp_id" name="emp_id"/>
		                    			</div>
		                    			<div style="flex:0.8; color: rgba(0, 0, 0, 0.7);">
		                    				<p id="emp_dnum"></p>
		                    				<p id="emp_bnum"></p>
		                    				<p id="emp_position"></p>
		                    				<p id="emp_tel"></p>
		                    				<p id="emp_email"></p>
			                    		</div>
		                    		</div>
		                    	</div>
		                    	<div style="display: flex; flex:0.5; border-top:1px solid rgba(0,0,0,0.1);">
		                    	</div>
			                </div>
			            </form>
			        </div>
					<!-- card-body end -->
			     </div>
			     <!-- card end -->
			</div> 
			<!-- modal body end -->
		</div>
		<!-- modal content end -->
	</div>
</div>
<!-- get_employee_info end -->
