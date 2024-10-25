<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="game" class="modal fade" tabindex="0" aria-labelledby="game" aria-hidden="true">
	<div class="modal-dialog modal-xl">
		<div class="modal-content" style="background-color: rgba(0,0,0,0.3); width:1240px !important; height:1200px !important; display: flex; justify-content: center; align-items: center; ">
			<div class="card" style="margin:0px; padding:0px; width:95%; height:95%; display: flex;">
				<div class="game">
				    <c:forEach var="i" begin="0" end="99" varStatus="inum">
				        <c:forEach var="j" begin="0" end="99" varStatus="jnum">
				            <div class="box" id="${inum.index}_${jnum.index}"></div>
				        </c:forEach>
				    </c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$('#game').on('shown.bs.modal', function (e) {
        const snake = [[0, 0]];
        const maxLength = 6;
        let direction = null;
        let canChangeDirection = true;
        $('#0_0').addClass('user');
        
        const monsters = [];
        const monsterCount = 50;
        const coins = [];
        const coinCount = 30;

        function gameOver() {
            alert('Game Over!'); // 게임 오버 시 알림
            clearInterval(gameInterval); // 게임 종료 시 인터벌 클리어
        }

        function gameClear() {
            alert('Game Clear!'); // 게임 클리어 시 알림
            clearInterval(gameInterval); // 게임 종료 시 인터벌 클리어
        }

        function initializeCoins() {
            for (let i = 0; i < coinCount; i++) {
                let row, col;
                do {
                    row = Math.floor(Math.random() * 100);
                    col = Math.floor(Math.random() * 100);
                } while (isPositionOccupied(row, col)); // 다른 객체와 겹치지 않도록
                coins.push([row, col]);
                $('#' + row + '_' + col).addClass('coin'); // 초기 코인 위치에 클래스 추가
            }
        }

        function isPositionOccupied(row, col) {
            if (snake.some(([r, c]) => r === row && c === col)) return true;
            if (monsters.some(monsterObj => 
                monsterObj.snake.some(([r, c]) => r === row && c === col)
            )) return true;
            if (coins.some(([r, c]) => r === row && c === col)) return true;
            return false;
        }

        function collectCoins() {
            coins.forEach((coin, index) => {
                const [row, col] = coin;
                if (snake[0][0] === row && snake[0][1] === col) {
                    $('#' + row + '_' + col).removeClass('coin');
                    coins.splice(index, 1);
                    if (coins.length === 0) {
                        gameClear();
                    }
                }
            });
        }

        function initializeMonsters() {
            for (let i = 0; i < monsterCount; i++) {
                const monsterSnake = [[Math.floor(Math.random() * 100), Math.floor(Math.random() * 100)]];
                const direction = getRandomDirection();
                monsters.push({ snake: monsterSnake, direction });
            }
        }

        function getRandomDirection() {
            const directions = ['right', 'left', 'up', 'down'];
            return directions[Math.floor(Math.random() * directions.length)];
        }

        function moveMonsters() {
            monsters.forEach(monsterObj => {
                const { snake, direction } = monsterObj;
                const head = snake[0];
                const newRow = head[0];
                const newCol = head[1];

                snake.forEach(([row, col]) => {
                    $('#' + row + '_' + col).removeClass('monster');
                });

                let moveRow = newRow;
                let moveCol = newCol;

                if (direction === 'right' && moveCol < 99) {
                    moveCol++;
                } else if (direction === 'left' && moveCol > 0) {
                    moveCol--;
                } else if (direction === 'up' && moveRow > 0) {
                    moveRow--;
                } else if (direction === 'down' && moveRow < 99) {
                    moveRow++;
                }

                snake.unshift([moveRow, moveCol]);

                if (snake.length > 15) {
                    snake.pop();
                }

                snake.forEach(([row, col]) => {
                    $('#' + row + '_' + col).addClass('monster');
                });

                if (Math.random() < 0.8) { 
                    monsterObj.direction = getRandomDirection();
                }
            });
        }

        $(document).on('keydown', function (e) {
            e.preventDefault();
            
            if (!canChangeDirection) return;
            canChangeDirection = false;
            
            for (let i = 0; i < snake.length; i++) {
                const [row, col] = snake[i];
                $('#' + row + '_' + col).removeClass('user');
            }

            let newRow = snake[0][0];
            let newCol = snake[0][1];

            if (e.key === 'ArrowRight' && direction !== 'left' && newCol < 99) {
                newCol++;
                direction = 'right';
            } else if (e.key === 'ArrowLeft' && direction !== 'right' && newCol > 0) {
                newCol--;
                direction = 'left';
            } else if (e.key === 'ArrowUp' && direction !== 'down' && newRow > 0) {
                newRow--;
                direction = 'up';
            } else if (e.key === 'ArrowDown' && direction !== 'up' && newRow < 99) {
                newRow++;
                direction = 'down';
            }

            snake.unshift([newRow, newCol]);

            if (snake.length > maxLength) {
                snake.pop();
            }

            for (let i = 0; i < snake.length; i++) {
                const [row, col] = snake[i];
                $('#' + row + '_' + col).addClass('user');
            }

            collectCoins();

            setTimeout(() => {
                canChangeDirection = true;
            }, 50);
        });

        function checkCollision() {
            $('.box.user.monster').each(function() {
                gameOver();
            });
        }

        const gameInterval = setInterval(() => {
            if (direction) {
                for (let i = 0; i < snake.length; i++) {
                    const [row, col] = snake[i];
                    $('#' + row + '_' + col).removeClass('user');
                }

                let newRow = snake[0][0];
                let newCol = snake[0][1];

                if (direction === 'right' && newCol < 99) {
                    newCol++;
                } else if (direction === 'left' && newCol > 0) {
                    newCol--;
                } else if (direction === 'up' && newRow > 0) {
                    newRow--;
                } else if (direction === 'down' && newRow < 99) {
                    newRow++;
                }

                snake.unshift([newRow, newCol]);

                if (snake.length > maxLength) {
                    snake.pop();
                }

                for (let i = 0; i < snake.length; i++) {
                    const [row, col] = snake[i];
                    $('#' + row + '_' + col).addClass('user');
                }

                moveMonsters();
                checkCollision();
                collectCoins();
            }
        }, 100);
        initializeCoins();
        initializeMonsters();
    });
</script>
