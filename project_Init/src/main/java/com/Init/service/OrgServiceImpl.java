package com.Init.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Init.persistence.OrgDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.Init.domain.MemberVO;

@Service
public class OrgServiceImpl implements OrgService {
    private static final Logger logger = LoggerFactory.getLogger(OrgServiceImpl.class);
    
    @Autowired
    private OrgDAO orgDAO;

    @Override
    public Map<String, Object> getFullOrgChartData() {
        List<MemberVO> allMembers = orgDAO.getAllMemPage();
        Map<String, Object> orgChart = new HashMap<>();
        
        // 사장 노드 생성
        MemberVO president = allMembers.stream()
            .filter(m -> "사장".equals(m.getEmp_position()))
            .findFirst()
            .orElse(null);
        
        orgChart.put("name", president != null ? president.getEmp_name() : "미정");
        orgChart.put("title", "사장");
        orgChart.put("children", new ArrayList<>());

        // 부사장별로 그룹화
        List<MemberVO> vicePresidents = allMembers.stream()
            .filter(m -> "부사장".equals(m.getEmp_position()))
            .collect(Collectors.toList());

        for (MemberVO vp : vicePresidents) {
            Map<String, Object> vpNode = createVicePresidentNode(vp, allMembers);
            if (vpNode != null) {
                ((List<Map<String, Object>>) orgChart.get("children")).add(vpNode);
            }
        }
        
        return orgChart;
    }

    private Map<String, Object> createVicePresidentNode(MemberVO vicePresident, List<MemberVO> allMembers) {
        Map<String, Object> vpNode = new HashMap<>();
        vpNode.put("name", vicePresident.getEmp_name());
        vpNode.put("title", "부사장"); // 본부 표시 제거
        vpNode.put("children", new ArrayList<>());

        // 각 지역 본부별로 그룹화 (서울, 부산, 대전 등)
        List<String> allBranches = allMembers.stream()
            .filter(m -> m.getEmp_bnum() != null)
            .map(MemberVO::getEmp_bnum)
            .distinct()
            .collect(Collectors.toList());

        for (String branchName : allBranches) {
            List<MemberVO> branchMembers = allMembers.stream()
                .filter(m -> branchName.equals(m.getEmp_bnum()) && 
                       "본부장".equals(m.getEmp_position()))
                .collect(Collectors.toList());

            if (!branchMembers.isEmpty()) {
                Map<String, Object> branchNode = createBranchNode(branchName, branchMembers, allMembers);
                if (branchNode != null) {
                    ((List<Map<String, Object>>) vpNode.get("children")).add(branchNode);
                }
            }
        }

        return vpNode;
    }

    private Map<String, Object> createBranchNode(String branchName, List<MemberVO> branchManagers, List<MemberVO> allMembers) {
        if (branchName == null || branchManagers == null || branchManagers.isEmpty()) {
            logger.warn("Invalid branch data: name={}, managers={}", branchName, branchManagers);
            return null;
        }

        Map<String, Object> branchNode = new HashMap<>();
        
        // 본부장 찾기
        MemberVO branchManager = branchManagers.stream()
            .filter(m -> "본부장".equals(m.getEmp_position()))
            .findFirst()
            .orElse(null);

        branchNode.put("name", branchManager != null ? branchManager.getEmp_name() : "미정");
        branchNode.put("title", branchName);
        branchNode.put("children", new ArrayList<>());

        // 해당 본부 산하의 부서별로 그룹화
        List<MemberVO> departmentMembers = allMembers.stream()
            .filter(m -> branchName.equals(m.getEmp_bnum()) && 
                   m.getDept_name() != null &&
                   !"본부장".equals(m.getEmp_position()))
            .collect(Collectors.toList());

        Map<String, List<MemberVO>> deptGroups = departmentMembers.stream()
            .collect(Collectors.groupingBy(MemberVO::getDept_name));

        for (Map.Entry<String, List<MemberVO>> entry : deptGroups.entrySet()) {
            Map<String, Object> deptNode = createDepartmentNode(entry.getKey(), entry.getValue());
            if (deptNode != null) {
                ((List<Map<String, Object>>) branchNode.get("children")).add(deptNode);
            }
        }

        return branchNode;
    }

    private Map<String, Object> createDepartmentNode(String deptName, List<MemberVO> deptMembers) {
        if (deptName == null || deptMembers == null || deptMembers.isEmpty()) {
            logger.warn("Invalid department data: name={}, members={}", deptName, deptMembers);
            return null;
        }

        Map<String, Object> deptNode = new HashMap<>();
        
        // 부장 찾기 (부서장 대신 부장으로 변경)
        MemberVO deptManager = deptMembers.stream()
            .filter(m -> "부장".equals(m.getEmp_position()))
            .findFirst()
            .orElse(null);

        deptNode.put("name", deptManager != null ? deptManager.getEmp_name() : "미정");
        deptNode.put("title", deptName);
        deptNode.put("children", new ArrayList<>());

        return deptNode;
    }

    @Override
    public List<MemberVO> getTeamMemPage(String deptId) {
        return orgDAO.getTeamMemPage(deptId);
    }
}