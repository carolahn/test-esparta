const A = [9, 3, 9, 3, 9, 7, 9];
const B = [4, 1, 1, 1, 1, 1, 1, 1, 1];

function solution(arr) {
  let curr = arr.shift();

  while (arr.length >= 0) {
    pairIndex = arr.indexOf(curr);
    if ((pairIndex === -1) | (arr.length === 0)) {
      return curr;
    }
    arr.splice(pairIndex, 1);
    curr = arr.shift();
  }

  return null;
}

console.log(solution(A));
console.log(solution(B));
