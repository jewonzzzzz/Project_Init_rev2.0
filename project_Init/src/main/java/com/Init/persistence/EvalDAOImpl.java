package com.Init.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.Init.domain.EvalVO;

@Repository
public class EvalDAOImpl implements EvalDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// Mapper namespace 정보 저장
	private static final String NAMESPACE = "com.Init.mapper.EvalMapper";
	
	// 성과평가 신규등록 하기
	@Override
	public void evalCreate(EvalVO vo) {
		sqlSession.insert(NAMESPACE+".evalCreate", vo);
	}
	
	// 올해 첫 평가번호가 있는지 확인하기
	@Override
	public String checkEvalId(String eval_id) {
		return sqlSession.selectOne(NAMESPACE+".checkEvalId", eval_id);
	}
	
	// 가장 최근의 eval_id 가져오기
	@Override
	public String getEvalId() {
		return sqlSession.selectOne(NAMESPACE+".getEvalId");
	}
	
	// 현재까지 평가내역 가져오기
	@Override
	public List<EvalVO> getEvalList() {
		return sqlSession.selectList(NAMESPACE+".getEvalList");
	}
	
	// 유형/연도/반기로 중복여부 확인
	@Override
	public EvalVO checkCreateEval(EvalVO vo) {
		return sqlSession.selectOne(NAMESPACE+".checkCreateEval", vo);
	}
	
	// 성과평가 리스트 삭제
	@Override
	public void deleteEvalInfo(EvalVO vo) {
		sqlSession.delete(NAMESPACE+".deleteEvalInfo", vo);
	}
	
	// 성과보고를 위한 성과평가리스트 가져오기
	@Override
	public EvalVO getEvalReportList() {
		return sqlSession.selectOne(NAMESPACE+".getEvalReportList");
	}
	
	// 성과보고 클릭 시 평가준비에서 성과보고로 변경
	@Override
	public void updateEvalInfoToReport(EvalVO vo) {
		sqlSession.update(NAMESPACE+".updateEvalInfoToReport", vo);
	}
	
	// 성과보고 페이지 업무성과 보고대상용 리스트 정보 가져오기
	@Override
	public EvalVO getEvalInfoForView(String eval_id) {
		return sqlSession.selectOne(NAMESPACE+".getEvalInfoForView", eval_id);
	}
	
	// 성과보고 내용 성과이력테이블에 저장하기
	@Override
	public void saveEvalReport(EvalVO vo) {
		sqlSession.insert(NAMESPACE+".saveEvalReport", vo);
	}
	
	// 성과보고 작성내역 확인용 가져오기
	@Override
	public EvalVO getHisEvaReport(EvalVO vo) {
		return sqlSession.selectOne(NAMESPACE+".getHisEvaReport", vo);
	}
	
	// 성과보고 내용 수정하기
	@Override
	public void updateEvalReport(EvalVO vo) {
		sqlSession.update(NAMESPACE+".updateEvalReport", vo);
	}
	
	// 성과관리페이지에서 평가시작으로 변경(이력은 평가미완료로 변경)
	@Override
	public void startEval(EvalVO vo) {
		sqlSession.update(NAMESPACE+".startEval", vo);
		sqlSession.update(NAMESPACE+".startEvalForHis", vo);
	}
	
	// 성과보고페이지 접근 시 이전 모든 이력 가져오기
	@Override
	public List<EvalVO> getHisEvalReportAll(String emp_id) {
		return sqlSession.selectList(NAMESPACE+".getHisEvalReportAll", emp_id);
	}
	
	// 성과평가 페이지 접근자 부서정보 가져오기
	@Override
	public EvalVO getEvaluatorInfo(String emp_id) {
		return sqlSession.selectOne(NAMESPACE+".getEvaluatorInfo",emp_id);
	}
	
	// 평가시작된 eval_id와 부서 하위직원 내역 가져오기
	@Override
	public List<EvalVO> getResultInfoForEval(EvalVO vo) {
		return sqlSession.selectList(NAMESPACE+".getResultInfoForEval", vo);
	}
	
	// 성과평가 상세페이지에서 보여줄 정보가져오기(his_id별)
	@Override
	public EvalVO getReportInfoForEval(String eval_his_id) {
		return sqlSession.selectOne(NAMESPACE+".getReportInfoForEval", eval_his_id);
	}
	
	// 성과평가 저장하기
	@Override
	public void saveResultEval(EvalVO vo) {
		sqlSession.update(NAMESPACE+".saveResultEval", vo);
	}
	
	// 성과관리페이지에서 평가종료로 변경(이력도 평가종료로 변경)
	@Override
	public void endEval(EvalVO vo) {
		sqlSession.update(NAMESPACE+".endEval", vo);
		sqlSession.update(NAMESPACE+".endEvalForHis", vo);
	}
	
	// 성과이력조회 이동 후 데이터 가져오기
	@Override
	public List<EvalVO> getEvalHisInquiry(String emp_id) {
		return sqlSession.selectList(NAMESPACE+".getEvalHisInquiry", emp_id);
	}
	
	// 성과관리 상세페이지에서 수정하기
	@Override
	public void evalUpdate(EvalVO vo) {
		sqlSession.update(NAMESPACE+".evalUpdate", vo);
	}
	
	
	
	
	
	
	
	
	
}
