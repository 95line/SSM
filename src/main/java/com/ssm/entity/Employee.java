package com.ssm.entity;

import javax.validation.constraints.Pattern;

public class Employee {
    private Integer empId;

    @Pattern(regexp = "(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,6}+$)",message = "用户名为6-16位的英文，数字的组合或者2-6位汉字")
    private String empName;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",message = "邮箱格式不正确！")
    private String empEmail;

    private String gender;

    private Integer departmentId;

    private Department department;

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empEmail, String gender, Integer departmentId) {
        this.empId = empId;
        this.empName = empName;
        this.empEmail = empEmail;
        this.gender = gender;
        this.departmentId = departmentId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
}