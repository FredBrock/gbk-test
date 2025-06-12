-- ======================================
-- 员工管理系统数据库脚朄1�7
-- 文件编码：GB18030
-- 创建时间＄1�72024幄1�7
-- ======================================
-- ����������
-- ����������
-- ����������
-- 创建员工信息衄1�7
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '员工编号',
    emp_name VARCHAR(50) NOT NULL COMMENT '员工姓名',
    department VARCHAR(30) COMMENT '扢�属部闄1�7',
    position VARCHAR(40) COMMENT '职位',
    salary DECIMAL(10,2) COMMENT '薪资',
    hire_date DATE COMMENT '入职日期',
    phone VARCHAR(20) COMMENT '联系电话',
    email VARCHAR(100) COMMENT '邮箱地址',
    status TINYINT DEFAULT 1 COMMENT '状��：1-在职＄1�70-离职'
) COMMENT '员工信息衄1�7';

-- 创建部门信息衄1�7
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '部门编号',
    dept_name VARCHAR(50) NOT NULL COMMENT '部门名称',
    manager_id INT COMMENT '部门经理编号',
    location VARCHAR(100) COMMENT '办公地点',
    budget DECIMAL(12,2) COMMENT '部门预算'
) COMMENT '部门信息衄1�7';

-- 创建项目信息衄1�7
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '项目编号',
    project_name VARCHAR(100) NOT NULL COMMENT '项目名称',
    start_date DATE COMMENT '弢�始日朄1�7',
    end_date DATE COMMENT '结束日期',
    budget DECIMAL(15,2) COMMENT '项目预算',
    status VARCHAR(20) DEFAULT '进行丄1�7' COMMENT '项目状��1�7'
) COMMENT '项目信息衄1�7';

-- 插入部门数据
INSERT INTO departments (dept_name, location, budget) VALUES
('研发郄1�7', '北京市朝阳区', 1000000.00),
('锢�售部', '上海市浦东新匄1�7', 800000.00),
('市场郄1�7', '广州市天河区', 600000.00),
('人力资源郄1�7', '深圳市南山区', 400000.00),
('财务郄1�7', '杭州市西湖区', 500000.00);

-- 插入员工数据
INSERT INTO employees (emp_name, department, position, salary, hire_date, phone, email) VALUES
('张三', '研发郄1�7', '高级工程帄1�7', 15000.00, '2023-01-15', '13812345678', 'zhangsan@company.com'),
('李四', '研发郄1�7', '前端弢�叄1�7', 12000.00, '2023-03-20', '13987654321', 'lisi@company.com'),
('王五', '锢�售部', '锢�售经琄1�7', 18000.00, '2022-11-10', '15612345678', 'wangwu@company.com'),
('赵六', '市场郄1�7', '市场专员', 8000.00, '2023-05-08', '18012345678', 'zhaoliu@company.com'),
('钱七', '人力资源郄1�7', 'HR主管', 13000.00, '2022-08-25', '17712345678', 'qianqi@company.com'),
('孙八', '财务郄1�7', '会计帄1�7', 10000.00, '2023-02-14', '13612345678', 'sunba@company.com');

-- 插入项目数据
INSERT INTO projects (project_name, start_date, end_date, budget, status) VALUES
('客户管理系统弢�叄1�7', '2024-01-01', '2024-06-30', 500000.00, '进行丄1�7'),
('移动应用升级', '2024-02-15', '2024-05-15', 300000.00, '进行丄1�7'),
('数据分析平台', '2023-10-01', '2024-03-31', 800000.00, '即将完成'),
('企业官网重构', '2024-03-01', '2024-07-01', 200000.00, '规划丄1�7');

-- ======================================
-- 常用查询脚本
-- ======================================

-- 查询扢�有在职员工信恄1�7
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
    MAX(salary) AS '朢�高薪资1�7',
    MIN(salary) AS '朢�低薪资1�7'
FROM employees 
WHERE status = 1
GROUP BY department
ORDER BY AVG(salary) DESC;

-- 查询薪资高于平均薪资的员巄1�7
SELECT 
    emp_name AS '员工姓名',
    department AS '部门',
    salary AS '薪资'
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees WHERE status = 1)
    AND status = 1
ORDER BY salary DESC;

-- 查询朢�近一年入职的员工
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
-- 数据更新和维护脚朄1�7
-- ======================================

-- 更新员工薪资（年度调薪）
UPDATE employees 
SET salary = salary * 1.05  -- 薪资上调5%
WHERE status = 1 
    AND YEAR(hire_date) < YEAR(CURDATE());

-- 更新项目状��1�7
UPDATE projects 
SET status = '已完戄1�7' 
WHERE end_date < CURDATE() 
    AND status != '已完戄1�7';

-- 删除超过5年的离职员工记录
DELETE FROM employees 
WHERE status = 0 
    AND DATEDIFF(CURDATE(), hire_date) > 1825;  -- 5幄1�7 = 1825处1�7

-- ======================================
-- 统计分析查询
-- ======================================

-- 部门预算使用情况分析
SELECT 
    d.dept_name AS '部门名称',
    d.budget AS '部门预算',
    SUM(e.salary * 12) AS '年度人工成本',
    (d.budget - SUM(e.salary * 12)) AS '剩余预算',
    ROUND((SUM(e.salary * 12) / d.budget * 100), 2) AS '预算使用玄1�7%'
FROM departments d
LEFT JOIN employees e ON d.dept_name = e.department AND e.status = 1
GROUP BY d.dept_id
ORDER BY '预算使用玄1�7%' DESC;

-- 项目投资回报分析
SELECT 
    project_name AS '项目名称',
    budget AS '项目预算',
    status AS '项目状��1�7',
    DATEDIFF(IFNULL(end_date, CURDATE()), start_date) AS '项目周期(处1�7)',
    CASE 
        WHEN status = '已完戄1�7' THEN '投资已完戄1�7'
        WHEN status = '进行丄1�7' THEN '投资进行丄1�7'
        ELSE '投资未开姄1�7'
    END AS '投资状��1�7'
FROM projects
ORDER BY budget DESC;
