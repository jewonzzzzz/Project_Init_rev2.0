<script src="${pageContext.request.contextPath }/resources/assets/js/login_alarm.js"></script>

<div class="modal fade" id="login_alarm_modal" tabindex="2" aria-labelledby="unread_workflow" aria-hidden="true" style="background-color: rgba(0,0,0,0.5);">
	<div class="modal-dialog modal-md" >
		<!-- modal content start -->
		<div class="modal-content" style="background-color: rgba(0,0,0,0.3);">
			<!-- modal body start -->
			<div class="modal-body">
				<div class="card" style="margin:0px; display:flex; flex-direction: column;">
					<div class="card-header" style="display:flex; background-color: rgba(0,0,0,0.1); justify-content: flex-end; padding: 15px 15px 0px 0px !important; border:0px !important;" >
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<!-- card body start -->
					<div class="card-body" style="background-color: rgba(0,0,0,0.1); border-top:0px !important;">
						<div id="welcome" style="display: flex; width:100%; height: 30px; border-bottom:1px solid rgba(0,0,0,0.1);"></div>
						<div class="form-group" id="received_workflows" style= "width:100%; display: flex; flex-direction:column; align-items: center; justify-content: center; "></div>
	                    <div class="form-group" id="sent_workflows" style= "width:100%; display: flex; flex-direction:column; align-items: center; justify-content: center; "></div>
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
