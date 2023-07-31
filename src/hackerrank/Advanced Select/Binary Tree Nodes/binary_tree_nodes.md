# Binary Tree Nodes

[문제 바로 가기](https://www.hackerrank.com/challenges/binary-search-tree-1/problem)

- concat 함수를 사용하면 훨씬 간단하게 해결할 수 있다.
- 부모 노드가 없다면 Root노드에 해당한다.
- N컬럼에 있는 값이 P컬럼에 있는 값이라면 부모노드의 역할도 한다는 뜻이기 때문에 Leaf 노드는 아니다. 다만, Root노드는 하나 뿐이고 Root노드를 찾는 쿼리문을 가장 처음에 둔다면 이미 Root노드는 걸러진 상태이기 때문에 Inner노드에 해당한다고 볼 수 있다.
- 이외의 경우는 모두 Leaf 노드에 해당한다.

## 최종 쿼리문

```mysql
SELECT 
    CASE
        WHEN P IS NULL THEN CONCAT(N, ' Root')
        WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, ' Inner')
        ELSE CONCAT(N, ' Leaf')
    END AS NP
FROM BST
ORDER BY N;
```