const A = [2, 1, 1, 2, 3, 1];
const B = [2, 1, 1, 2, 3, 1, 7, 6, 6, 7, 8, 1, 1, 7, 2, 1];

function solution(arr) {
  let count = 0;

  while (arr.length > 0) {
    let curr = arr.shift();
    arr = arr.filter((num) => num !== curr);
    count++;
  }

  return count;
}

console.log(solution(A));
console.log(solution(B));
