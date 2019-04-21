package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.entity.Employee;
import com.ssm.entity.Msg;
import com.ssm.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/")
    public String index(){
        return "index";
    }

    /**
     * 查询员工数据
     * @return
     */
    @RequestMapping(value = "/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pageNo, Model model){

        //使用pageHelper进行分页
        //传入参数：当前页码；每页的大小
        PageHelper.startPage(pageNo,5);

        //startPage后面紧跟查询操作
        List<Employee> emps =  employeeService.getAll();

        //使用PageInfo封装查询后的结果,传入参数（查询到的数据，需要连续显示的页数）
        PageInfo pageInfo = new PageInfo(emps,5);

        //将数据传给页面
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }


    /**
     * 查询全部员工信息
     * @param pageNo
     * @return
     */
    @RequestMapping(value = "/empss")
    @ResponseBody
    public Msg getEmpsWithJSON(@RequestParam(value = "pn",defaultValue = "1") Integer pageNo){
        //使用pageHelper进行分页
        //传入参数：当前页码；每页的大小
        PageHelper.startPage(pageNo,5);

        //startPage后面紧跟查询操作
        List<Employee> emps =  employeeService.getAll();

        //使用PageInfo封装查询后的结果,传入参数（查询到的数据，需要连续显示的页数）
        PageInfo pageInfo = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

    /**
     * 保存员工信息
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp" ,method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
//    public Msg saveEmp(Employee employee){
        if (result.hasErrors()){
            Map<String,Object> map = new HashMap<String, Object>();

            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(String empName){

        String regName = "(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,6}+$)";
        if (!empName.matches(regName)){
            return Msg.fail().add("va_msg","用户名为6-16位的英文，数字的组合或者2-6位汉字");
        }

        Boolean b = employeeService.checkUser(empName);
        if (b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }

    /**
     * 根据ID查询员工信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/empss/{id}" , method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmployeeById(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmpById(id);
        return Msg.success().add("employee",employee);
    }

    /**
     * 更新员工信息
     * @param employee
     * @param request
     * @return
     */
    @RequestMapping(value = "/empss/{id}" , method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmployee(@PathVariable("id") Integer id,Employee employee , HttpServletRequest request){
        employee.setEmpId(id);
//        System.out.println(employee.getEmpId());
//        System.out.println(employee.getEmpName());
//        System.out.println(employee.getEmpEmail());
//        System.out.println(employee.getGender());
//        System.out.println(employee.getDepartmentId());
        employeeService.updateEmployee(employee);
        return Msg.success();
    }

    @RequestMapping(value = "/empss/{ids}" , method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmployee(@PathVariable("ids") String ids){
        System.out.println(ids);
        if (ids.contains("-")){
            List<Integer> list = new ArrayList<Integer>();
            String[] str_ids = ids.split("-");

            for (String string:str_ids) {
                list.add(Integer.parseInt(string));
                System.out.println(string);
            }
            employeeService.deleteBatch(list);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmployee(id);
        }

        return Msg.success();
    }

}
