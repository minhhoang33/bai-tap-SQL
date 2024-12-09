create table if not exists Person (
    id INT PRIMARY KEY auto_increment,
    fullname VARCHAR(50),
    country VARCHAR(50),
    job VARCHAR(14),
    birthday DATE,
    gender VARCHAR(50),
    salary INT,
    hobbies VARCHAR(27)
);

CREATE TABLE if not exists Post (
                      id INT,
                      title VARCHAR(250),
                      content TEXT,
                      createdAt DATETIME,
                      authorId INT,
                      PRIMARY KEY (id),
                      FOREIGN KEY (authorId) REFERENCES Person (id)

);

SELECT p.fullname, p.job, post.title, post.createdAt
FROM Person p
         JOIN Post post ON p.id = post.authorId
WHERE p.job = 'Programmer' AND post.createdAt > '2023-01-01';

SELECT COUNT(*) AS TotalPosts2022
FROM Post
WHERE YEAR(createdAt) = 2022;

SELECT DISTINCT p.*
FROM Person p
         JOIN Post post ON p.id = post.authorId
WHERE YEAR(post.createdAt) = 2022;

SELECT p.fullname, p.country, p.job, post.title, post.createdAt
FROM Person p
         JOIN Post post ON p.id = post.authorId
ORDER BY post.createdAt DESC
LIMIT 3;

SELECT p.fullname, COUNT(post.id) AS TotalPosts
FROM Person p
         LEFT JOIN Post post ON p.id = post.authorId
GROUP BY p.id, p.fullname;

SELECT p.fullname, COUNT(post.id) AS TotalPosts
FROM Person p
         JOIN Post post ON p.id = post.authorId
WHERE p.country = 'China'
GROUP BY p.id, p.fullname;

SELECT p.fullname, COUNT(post.id) AS TotalPosts
FROM Person p
         JOIN Post post ON p.id = post.authorId
WHERE FIND_IN_SET('Swimming', p.hobbies) > 0 AND YEAR(post.createdAt) = 2023
GROUP BY p.id, p.fullname;

SELECT MONTH(createdAt) AS Month, COUNT(id) AS TotalPosts
FROM Post
WHERE YEAR(createdAt) = 2023
GROUP BY MONTH(createdAt)
ORDER BY TotalPosts DESC
LIMIT 1;

SELECT YEAR(createdAt) AS Year, COUNT(id) AS TotalPosts
FROM Post
GROUP BY YEAR(createdAt)
ORDER BY TotalPosts ASC
LIMIT 1;

SELECT YEAR(createdAt) AS Year, COUNT(id) AS TotalPosts
FROM Post
GROUP BY YEAR(createdAt)
ORDER BY TotalPosts DESC
LIMIT 1;

SELECT p.*, COUNT(post.id) AS TotalPosts
FROM Person p
         JOIN Post post ON p.id = post.authorId
WHERE YEAR(post.createdAt) = 2023
GROUP BY p.id
ORDER BY TotalPosts DESC
LIMIT 1;

SELECT p.*
FROM Person p
         JOIN (
    SELECT authorId, COUNT(id) AS TotalPosts
    FROM Post
    WHERE YEAR(createdAt) = 2022
    GROUP BY authorId
    HAVING TotalPosts > 2
) filtered_posts ON p.id = filtered_posts.authorId;





