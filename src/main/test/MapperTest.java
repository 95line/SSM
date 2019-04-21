
/**
 *测试DAO层
 */

import com.ssm.dao.DepartmentMapper;
import com.ssm.dao.EmployeeMapper;
import com.ssm.entity.Department;
import com.ssm.entity.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 1.导入SpringTest包
 * 2.@ContextConfiguration指定spring配置文件的位置
 *3.@Autowired使用的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring/applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testInsertDept(){

        System.out.println(departmentMapper);

        //插入几个部门
        departmentMapper.insertSelective(new Department(null,"开发部"));

        departmentMapper.insertSelective(new Department(null,"测试部"));

    }

    @Test
    public void testInsertEmployee(){
        System.out.println(employeeMapper);

        //单个插入
        //employeeMapper.insertSelective(new Employee(null,"jifubiao","jifubiao95@163.com","M",1));

        //批量插入
        //首先配置一个sqlsession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            mapper.insertSelective(new Employee(null,"Jack"+uid,uid+"@163.com","M",1));
        }
    }
}
