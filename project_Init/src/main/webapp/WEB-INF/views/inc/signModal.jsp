<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<!-- 결재요청용 모달  -->
	      <div
	      class="modal fade"
	      id="addRowModal"
	      tabindex="-1"
	      role="dialog"
	      aria-hidden="true"
	      >
	        <div class="modal-dialog" role="document" style="max-width: 1100px; margin-top: 100px;">
	          <div class="modal-content" style="width: 1100px;">
	            <div style="display: flex; justify-content: space-between;">
	              <div class="col-6">
	                <div class="modal-header border-0" style="padding-bottom: 5px;">
	                  <h5 class="modal-title">
	                    <span class="fw-mediumbold"> <b>직원정보</b></span>
	                  </h5>
	                </div>
	                <div class="modal-body">
	                  <p class="small">추가하기를 누르면 오른쪽 결재요청 페이지에 추가됩니다.</p>
	                <div id="modalNextContent">
			          <table class="table table-bordered" id="modalTable">
					    <thead>
					      <tr>
					        <th id="topText" colspan="5" 
					        style="text-align: center;"></th>
					      </tr>
					      <tr>
	                        <th style="text-align: center; background-color: #f8f9fa">사번</th>
	                        <th style="text-align: center; background-color: #f8f9fa">직급</th>
	                        <th style="text-align: center; background-color: #f8f9fa">이름</th>
	                        <th style="text-align: center; background-color: #f8f9fa">선택</th>
					      </tr>
					    </thead>
					    <tbody>
					    </tbody>
				      </table>
	                </div>
	              </div>
	            </div>
	            <div>
	              <div class="modal-header border-0" style="padding-bottom: 5px;">
	                <h5 class="modal-title">
	                  <span class="fw-mediumbold"><b>결재요청</b></span>
	                </h5>
	                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
	                   <span aria-hidden="true">×</span>
	                </button>
	              </div>
	              <div class="modal-body">
	                <p class="small">결재자와 결재유형을 선택하여 결재요청을 할 수 있습니다.</p>
	                <table class="table table-bordered" id="signTable">
					  <thead>
					    <tr>
	                      <th style="text-align: center; background-color: #f8f9fa">직급</th>
	                      <th style="text-align: center; background-color: #f8f9fa">이름</th>
	                      <th style="text-align: center; background-color: #f8f9fa">결재유형</th>
	                      <th style="text-align: center; background-color: #f8f9fa">삭제</th>
					    </tr>
					  </thead>
					  <tbody>
					  </tbody>
				    </table>
				    <div class="form-group" style="padding:0px;">
				      <div class="input-group mb-3">
				        <span class="input-group-text">결재요청명</span>
				        <input id="signTitle" name="wf_title" type="text" class="form-control" placeholder="결재요청명을 작성하세요" aria-label="Username" aria-describedby="basic-addon1">
				      </div>
				      <textarea class="form-control" id="signContent" rows="3" name="wf_content"
				                placeholder="결재요청 내용을 입력하세요"></textarea>
				    </div>
	              </div>
	              <div class="modal-footer border-0" style="justify-content: center;">
	                <button type="button" id="signRequestBtn" class="btn btn-primary">결재요청</button>
	                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
	              </div>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>