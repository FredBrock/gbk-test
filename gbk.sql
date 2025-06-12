-- ======================================
-- 员工管理系统数据库脚本
-- 文件编码：GB18030
-- 创建时间：2024年
-- ======================================

-- 创建员工信息表
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '员工编号',
    emp_name VARCHAR(50) NOT NULL COMMENT '员工姓名',
    department VARCHAR(30) COMMENT '所属部门',
    position VARCHAR(40) COMMENT '职位',
    salary DECIMAL(10,2) COMMENT '薪资',
    hire_date DATE COMMENT '入职日期',
    phone VARCHAR(20) COMMENT '联系电话',
    email VARCHAR(100) COMMENT '邮箱地址',
    status TINYINT DEFAULT 1 COMMENT '状态：1-在职，0-离职'
) COMMENT '员工信息表';

-- 创建部门信息表
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '部门编号',
    dept_name VARCHAR(50) NOT NULL COMMENT '部门名称',
    manager_id INT COMMENT '部门经理编号',
    location VARCHAR(100) COMMENT '办公地点',
    budget DECIMAL(12,2) COMMENT '部门预算'
) COMMENT '部门信息表';

-- 创建项目信息表
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '项目编号',
    project_name VARCHAR(100) NOT NULL COMMENT '项目名称',
    start_date DATE COMMENT '开始日期',
    end_date DATE COMMENT '结束日期',
    budget DECIMAL(15,2) COMMENT '项目预算',
    status VARCHAR(20) DEFAULT '进行中' COMMENT '项目状态'
) COMMENT '项目信息表';

-- 插入部门数据
INSERT INTO departments (dept_name, location, budget) VALUES
('研发部', '北京市朝阳区', 1000000.00),
('销售部', '上海市浦东新区', 800000.00),
('市场部', '广州市天河区', 600000.00),
('人力资源部', '深圳市南山区', 400000.00),
('财务部', '杭州市西湖区', 500000.00);

-- 插入员工数据
INSERT INTO employees (emp_name, department, position, salary, hire_date, phone, email) VALUES
('张三', '研发部', '高级工程师', 15000.00, '2023-01-15', '13812345678', 'zhangsan@company.com'),
('李四', '研发部', '前端开发', 12000.00, '2023-03-20', '13987654321', 'lisi@company.com'),
('王五', '销售部', '销售经理', 18000.00, '2022-11-10', '15612345678', 'wangwu@company.com'),
('赵六', '市场部', '市场专员', 8000.00, '2023-05-08', '18012345678', 'zhaoliu@company.com'),
('钱七', '人力资源部', 'HR主管', 13000.00, '2022-08-25', '17712345678', 'qianqi@company.com'),
('孙八', '财务部', '会计师', 10000.00, '2023-02-14', '13612345678', 'sunba@company.com');

-- 插入项目数据
INSERT INTO projects (project_name, start_date, end_date, budget, status) VALUES
('客户管理系统开发', '2024-01-01', '2024-06-30', 500000.00, '进行中'),
('移动应用升级', '2024-02-15', '2024-05-15', 300000.00, '进行中'),
('数据分析平台', '2023-10-01', '2024-03-31', 800000.00, '即将完成'),
('企业官网重构', '2024-03-01', '2024-07-01', 200000.00, '规划中');

-- ======================================
-- 常用查询脚本
-- ======================================

-- 查询所有在职员工信息
SELECT 
    emp_id AS '员工编号',
    emp_name AS '姓名',
    department AS '部门',
    position AS '职位',
    salary AS '薪资',
    hire_date AS '入职日期'
FROM employees 
WHERE status = 1
ORDER BY salary DESC;

-- 查询各部门员工数量和平均薪资
SELECT 
    department AS '部门',
    COUNT(*) AS '员工数量',
    AVG(salary) AS '平均薪资',
    MAX(salary) AS '最高薪资',
    MIN(salary) AS '最低薪资'
FROM employees 
WHERE status = 1
GROUP BY department
ORDER BY AVG(salary) DESC;

-- 查询薪资高于平均薪资的员工
SELECT 
    emp_name AS '员工姓名',
    department AS '部门',
    salary AS '薪资'
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees WHERE status = 1)
    AND status = 1
ORDER BY salary DESC;

-- 查询最近一年入职的员工
SELECT 
    emp_name AS '员工姓名',
    department AS '部门',
    hire_date AS '入职日期',
    DATEDIFF(CURDATE(), hire_date) AS '入职天数'
FROM employees 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    AND status = 1
ORDER BY hire_date DESC;

-- ======================================
-- 数据更新和维护脚本
-- ======================================

-- 更新员工薪资（年度调薪）
UPDATE employees 
SET salary = salary * 1.05  -- 薪资上调5%
WHERE status = 1 
    AND YEAR(hire_date) < YEAR(CURDATE());

-- 更新项目状态
UPDATE projects 
SET status = '已完成' 
WHERE end_date < CURDATE() 
    AND status != '已完成';

-- 删除超过5年的离职员工记录
DELETE FROM employees 
WHERE status = 0 
    AND DATEDIFF(CURDATE(), hire_date) > 1825;  -- 5年 = 1825天

-- ======================================
-- 统计分析查询
-- ======================================

-- 部门预算使用情况分析
SELECT 
    d.dept_name AS '部门名称',
    d.budget AS '部门预算',
    SUM(e.salary * 12) AS '年度人工成本',
    (d.budget - SUM(e.salary * 12)) AS '剩余预算',
    ROUND((SUM(e.salary * 12) / d.budget * 100), 2) AS '预算使用率%'
FROM departments d
LEFT JOIN employees e ON d.dept_name = e.department AND e.status = 1
GROUP BY d.dept_id
ORDER BY '预算使用率%' DESC;

-- 项目投资回报分析
SELECT 
    project_name AS '项目名称',
    budget AS '项目预算',
    status AS '项目状态',
    DATEDIFF(IFNULL(end_date, CURDATE()), start_date) AS '项目周期(天)',
    CASE 
        WHEN status = '已完成' THEN '投资已完成'
        WHEN status = '进行中' THEN '投资进行中'
        ELSE '投资未开始'
    END AS '投资状态'
FROM projects
ORDER BY budget DESC;
