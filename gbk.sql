-- ======================================
-- 鍛樺伐绠＄悊绯荤粺鏁版嵁搴撹剼鏈�
-- 鏂囦欢缂栫爜锛欸B18030
-- 鍒涘缓鏃堕棿锛�2024骞�
-- ======================================
-- 正常的文字
-- 正常的文字
-- 正常的文字
-- 鍒涘缓鍛樺伐淇℃伅琛�
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '鍛樺伐缂栧彿',
    emp_name VARCHAR(50) NOT NULL COMMENT '鍛樺伐濮撳悕',
    department VARCHAR(30) COMMENT '鎵€灞為儴闂�',
    position VARCHAR(40) COMMENT '鑱屼綅',
    salary DECIMAL(10,2) COMMENT '钖祫',
    hire_date DATE COMMENT '鍏ヨ亴鏃ユ湡',
    phone VARCHAR(20) COMMENT '鑱旂郴鐢佃瘽',
    email VARCHAR(100) COMMENT '閭鍦板潃',
    status TINYINT DEFAULT 1 COMMENT '鐘舵€侊細1-鍦ㄨ亴锛�0-绂昏亴'
) COMMENT '鍛樺伐淇℃伅琛�';

-- 鍒涘缓閮ㄩ棬淇℃伅琛�
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '閮ㄩ棬缂栧彿',
    dept_name VARCHAR(50) NOT NULL COMMENT '閮ㄩ棬鍚嶇О',
    manager_id INT COMMENT '閮ㄩ棬缁忕悊缂栧彿',
    location VARCHAR(100) COMMENT '鍔炲叕鍦扮偣',
    budget DECIMAL(12,2) COMMENT '閮ㄩ棬棰勭畻'
) COMMENT '閮ㄩ棬淇℃伅琛�';

-- 鍒涘缓椤圭洰淇℃伅琛�
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT COMMENT '椤圭洰缂栧彿',
    project_name VARCHAR(100) NOT NULL COMMENT '椤圭洰鍚嶇О',
    start_date DATE COMMENT '寮€濮嬫棩鏈�',
    end_date DATE COMMENT '缁撴潫鏃ユ湡',
    budget DECIMAL(15,2) COMMENT '椤圭洰棰勭畻',
    status VARCHAR(20) DEFAULT '杩涜涓�' COMMENT '椤圭洰鐘舵€�'
) COMMENT '椤圭洰淇℃伅琛�';

-- 鎻掑叆閮ㄩ棬鏁版嵁
INSERT INTO departments (dept_name, location, budget) VALUES
('鐮斿彂閮�', '鍖椾含甯傛湞闃冲尯', 1000000.00),
('閿€鍞儴', '涓婃捣甯傛郸涓滄柊鍖�', 800000.00),
('甯傚満閮�', '骞垮窞甯傚ぉ娌冲尯', 600000.00),
('浜哄姏璧勬簮閮�', '娣卞湷甯傚崡灞卞尯', 400000.00),
('璐㈠姟閮�', '鏉窞甯傝タ婀栧尯', 500000.00);

-- 鎻掑叆鍛樺伐鏁版嵁
INSERT INTO employees (emp_name, department, position, salary, hire_date, phone, email) VALUES
('寮犱笁', '鐮斿彂閮�', '楂樼骇宸ョ▼甯�', 15000.00, '2023-01-15', '13812345678', 'zhangsan@company.com'),
('鏉庡洓', '鐮斿彂閮�', '鍓嶇寮€鍙�', 12000.00, '2023-03-20', '13987654321', 'lisi@company.com'),
('鐜嬩簲', '閿€鍞儴', '閿€鍞粡鐞�', 18000.00, '2022-11-10', '15612345678', 'wangwu@company.com'),
('璧靛叚', '甯傚満閮�', '甯傚満涓撳憳', 8000.00, '2023-05-08', '18012345678', 'zhaoliu@company.com'),
('閽变竷', '浜哄姏璧勬簮閮�', 'HR涓荤', 13000.00, '2022-08-25', '17712345678', 'qianqi@company.com'),
('瀛欏叓', '璐㈠姟閮�', '浼氳甯�', 10000.00, '2023-02-14', '13612345678', 'sunba@company.com');

-- 鎻掑叆椤圭洰鏁版嵁
INSERT INTO projects (project_name, start_date, end_date, budget, status) VALUES
('瀹㈡埛绠＄悊绯荤粺寮€鍙�', '2024-01-01', '2024-06-30', 500000.00, '杩涜涓�'),
('绉诲姩搴旂敤鍗囩骇', '2024-02-15', '2024-05-15', 300000.00, '杩涜涓�'),
('鏁版嵁鍒嗘瀽骞冲彴', '2023-10-01', '2024-03-31', 800000.00, '鍗冲皢瀹屾垚'),
('浼佷笟瀹樼綉閲嶆瀯', '2024-03-01', '2024-07-01', 200000.00, '瑙勫垝涓�');

-- ======================================
-- 甯哥敤鏌ヨ鑴氭湰
-- ======================================

-- 鏌ヨ鎵€鏈夊湪鑱屽憳宸ヤ俊鎭�
SELECT 
    emp_id AS '鍛樺伐缂栧彿',
    emp_name AS '濮撳悕',
    department AS '閮ㄩ棬',
    position AS '鑱屼綅',
    salary AS '钖祫',
    hire_date AS '鍏ヨ亴鏃ユ湡'
FROM employees 
WHERE status = 1
ORDER BY salary DESC;

-- 鏌ヨ鍚勯儴闂ㄥ憳宸ユ暟閲忓拰骞冲潎钖祫 
SELECT 
    department AS '閮ㄩ棬',
    COUNT(*) AS '鍛樺伐鏁伴噺',
    AVG(salary) AS '骞冲潎钖祫',
    MAX(salary) AS '鏈€楂樿柂璧�',
    MIN(salary) AS '鏈€浣庤柂璧�'
FROM employees 
WHERE status = 1
GROUP BY department
ORDER BY AVG(salary) DESC;

-- 鏌ヨ钖祫楂樹簬骞冲潎钖祫鐨勫憳宸�
SELECT 
    emp_name AS '鍛樺伐濮撳悕',
    department AS '閮ㄩ棬',
    salary AS '钖祫'
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees WHERE status = 1)
    AND status = 1
ORDER BY salary DESC;

-- 鏌ヨ鏈€杩戜竴骞村叆鑱岀殑鍛樺伐
SELECT 
    emp_name AS '鍛樺伐濮撳悕',
    department AS '閮ㄩ棬',
    hire_date AS '鍏ヨ亴鏃ユ湡',
    DATEDIFF(CURDATE(), hire_date) AS '鍏ヨ亴澶╂暟'
FROM employees 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    AND status = 1
ORDER BY hire_date DESC;

-- ======================================
-- 鏁版嵁鏇存柊鍜岀淮鎶よ剼鏈�
-- ======================================

-- 鏇存柊鍛樺伐钖祫锛堝勾搴﹁皟钖級
UPDATE employees 
SET salary = salary * 1.05  -- 钖祫涓婅皟5%
WHERE status = 1 
    AND YEAR(hire_date) < YEAR(CURDATE());

-- 鏇存柊椤圭洰鐘舵€�
UPDATE projects 
SET status = '宸插畬鎴�' 
WHERE end_date < CURDATE() 
    AND status != '宸插畬鎴�';

-- 鍒犻櫎瓒呰繃5骞寸殑绂昏亴鍛樺伐璁板綍
DELETE FROM employees 
WHERE status = 0 
    AND DATEDIFF(CURDATE(), hire_date) > 1825;  -- 5骞� = 1825澶�

-- ======================================
-- 缁熻鍒嗘瀽鏌ヨ
-- ======================================

-- 閮ㄩ棬棰勭畻浣跨敤鎯呭喌鍒嗘瀽
SELECT 
    d.dept_name AS '閮ㄩ棬鍚嶇О',
    d.budget AS '閮ㄩ棬棰勭畻',
    SUM(e.salary * 12) AS '骞村害浜哄伐鎴愭湰',
    (d.budget - SUM(e.salary * 12)) AS '鍓╀綑棰勭畻',
    ROUND((SUM(e.salary * 12) / d.budget * 100), 2) AS '棰勭畻浣跨敤鐜�%'
FROM departments d
LEFT JOIN employees e ON d.dept_name = e.department AND e.status = 1
GROUP BY d.dept_id
ORDER BY '棰勭畻浣跨敤鐜�%' DESC;

-- 椤圭洰鎶曡祫鍥炴姤鍒嗘瀽
SELECT 
    project_name AS '椤圭洰鍚嶇О',
    budget AS '椤圭洰棰勭畻',
    status AS '椤圭洰鐘舵€�',
    DATEDIFF(IFNULL(end_date, CURDATE()), start_date) AS '椤圭洰鍛ㄦ湡(澶�)',
    CASE 
        WHEN status = '宸插畬鎴�' THEN '鎶曡祫宸插畬鎴�'
        WHEN status = '杩涜涓�' THEN '鎶曡祫杩涜涓�'
        ELSE '鎶曡祫鏈紑濮�'
    END AS '鎶曡祫鐘舵€�'
FROM projects
ORDER BY budget DESC;
