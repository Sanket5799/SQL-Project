-- 1) What is the total amount each cutomer spent on Zomato ?
select s.userid, sum(p.price) as Total_amt_spent
from product p
inner join sales s
on p.product_id = s.product_id
group by s.userid;

-- 2) How many days each customer visited Zomato ?
select userid, count(distinct created_date) as Days_Visited
from sales
group by userid;


-- 3) Which was the first product purchased by each customer ?
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY userid ORDER BY created_date) AS RNK
    FROM sales
) as ranked_sales
WHERE RNK = 1;

-- 4) What is the most purchased item on the meu and how many times was it purchased by all the customers ?
SELECT p.product_name, COUNT(*) AS total_purchases
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_purchases DESC
LIMIT 1;

-- 5) What item was the most popular for each customer ?
select*from
(select*, row_number() over (partition by userid order by cnt desc) rnk from
(select userid,product_id,count(product_id)cnt 
  from sales
   group by userid,product_id)a)b
   where rnk = 1;





