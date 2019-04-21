package com.ssm.service;

import com.ssm.dao.DepartmentMapper;
import com.ssm.entity.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAllDepts() {
        List<Department> depts = departmentMapper.selectByExample(null);
        return depts;
    }
}
