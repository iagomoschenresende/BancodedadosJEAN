-- questão 1

SELECT officer.first_name, officer.last_name, business.name AS business_name, customer.city
FROM officer
JOIN business ON officer.business_id = business.id
JOIN customer ON business.customer_id = customer.id;

-- questao 2

SELECT
    CASE
        WHEN customer.type = 'juridica' THEN business.name
        ELSE CONCAT(customer.first_name, ' ', customer.last_name)
    END AS customer_name
FROM
    customer
JOIN
    account ON customer.id = account.customer_id
JOIN
    business ON customer.id = business.customer_id
WHERE
    account.city <> business.city;

--questao 3

SELECT
    employee.name,
    YEAR(transaction.date) AS transaction_year,
    COUNT(transaction.id) AS transaction_count
FROM
    employee
LEFT JOIN
    account ON employee.id = account.open_emp_id
LEFT JOIN
    transaction ON account.id = transaction.account_id
GROUP BY
    employee.id,
    transaction_year
ORDER BY
    employee.name ASC,
    transaction_year ASC;

--questao 4

SELECT
    a.id AS account_id,
    CASE
        WHEN c.type = 'E' THEN c.name
        WHEN c.type = 'I' THEN CONCAT(c.first_name, ' ', c.last_name)
    END AS account_holder_name,
    b.name AS branch_name,
    a.balance AS max_balance
FROM
    account AS a
JOIN
    branch AS b ON a.branch_id = b.id
JOIN
    customer AS c ON a.cust_id = c.id
JOIN
    (
        SELECT
            branch_id,
            MAX(balance) AS max_balance
        FROM
            account
        GROUP BY
            branch_id
    ) AS max_bal ON a.branch_id = max_bal.branch_id AND a.balance = max_bal.max_balance;
    
-- questao 5

-- Criar uma visualização para a consulta 2
CREATE VIEW cliente_contas_fora_cidade AS
SELECT
    CASE
        WHEN c.type = 'E' THEN c.name
        WHEN c.type = 'I' THEN CONCAT(c.first_name, ' ', c.last_name)
    END AS account_holder_name,
    a.city AS account_city,
    b.city AS branch_city
FROM
    account AS a
JOIN
    branch AS b ON a.branch_id = b.id
JOIN
    customer AS c ON a.cust_id = c.id
WHERE
    a.city <> b.city;

-- Criar uma visualização para a consulta 4
CREATE VIEW contas_maior_saldo_agencia AS
SELECT
    a.id AS account_id,
    CASE
        WHEN c.type = 'E' THEN c.name
        WHEN c.type = 'I' THEN CONCAT(c.first_name, ' ', c.last_name)
    END AS account_holder_name,
    b.name AS branch_name,
    a.balance AS max_balance
FROM
    account AS a
JOIN
    branch AS b ON a.branch_id = b.id
JOIN
    customer AS c ON a.cust_id = c.id
JOIN
    (
        SELECT
            branch_id,
            MAX(balance) AS max_balance
        FROM
            account
        GROUP BY
            branch_id
    ) AS max_bal ON a.branch_id = max_bal.branch_id AND a.balance = max_bal.max_balance;