const N = 10;
const M = 4;

function solution(N, M) {
  let eaten = [];
  let curr = 0;
  let next = (curr + M) % N;

  eaten.push(curr);

  while (!eaten.includes(next)) {
    eaten.push(next);
    curr = next;
    next = (curr + M) % N;
  }

  return eaten.length;
}

console.log(solution(N, M));
