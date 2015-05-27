# Snake for Neovim! Adapted from https://gist.github.com/sanchitgangwar/2158084
# To install, create a ~/.vim/rplugin/python/snake.py file with this
# code, then run `nvim -c 'UpdateRemotePlugins' -c 'q'` from a shell.
#
# Make sure you have read the internal help explaining how to setup python
# host for external plugins(:help nvim-python)
#
# To start a new game, use the `:SnakeStart` command on an empty buffer(uses 80
# columns and 20 rows)
from threading import Thread, Lock
from time import sleep
from random import randint
import neovim

class Game(Thread):
    def __init__(self, vim):
        super(Game, self).__init__()
        self.daemon = True
        self.vim = vim
        self.buf = vim.current.buffer
        self.key = 'right'
        self.prevKey = 'right'
        self.score = 0
        # Initial snake co-ordinates
        self.snake = [[4,10], [4,9], [4,8]]
        # First food co-ordinates
        self.food = [10,20]
        self.lock = Lock()
        self.key_subscribe('k', 'up')
        self.key_subscribe('j', 'down')
        self.key_subscribe('h', 'left')
        self.key_subscribe('l', 'right')
        self.key_subscribe('<esc>', 'esc')
        self.key_subscribe('<space>', 'space')
        # Fill the buffer
        empty = ' ' * 80
        self.buf[0] = empty
        for n in xrange(20):
            self.buf.append(empty)
        # Print the food
        self.addstr(self.food[0], self.food[1], '*')


    def key_subscribe(self, key, to):
        cid = self.vim.channel_id
        self.vim.command(
            ('nnoremap <silent> <buffer> %s ' +
             ':call rpcnotify(%d, "keypress", "%s")<cr>') %
            (key, cid, to))


    def key_unsubscribe(self, key):
        self.vim.command('unmap <buffer> %s' % key)


    def run(self):
        timeout = 0.05

        while self.key != 'esc':
            sleep(timeout)
            with self.lock:
                if self.key == 'space':
                    # If SPACE BAR is pressed pause the snake and wait for
                    # another
                    self.key = None
                    while self.key != 'space':
                        sleep(timeout)
                    self.key = self.prevKey
                    continue

                # Calculates the new coordinates of the head of the snake.
                # NOTE: len(snake) increases. This is taken care of later at
                # [1].
                self.snake.insert(0, [
                    self.snake[0][0] +
                        (self.key == 'down' and 1) +
                        (self.key == 'up' and -1),
                    self.snake[0][1] +
                        (self.key == 'left' and -1) +
                        (self.key == 'right' and 1)
                ])

                # If snake crosses the boundaries, make it enter from the other
                # side
                if self.snake[0][0] == 0: self.snake[0][0] = 18
                if self.snake[0][1] == 0: self.snake[0][1] = 58
                if self.snake[0][0] == 19: self.snake[0][0] = 1
                if self.snake[0][1] == 59: self.snake[0][1] = 1

                l = len(self.snake)
                trail = self.snake[1:]
                if self.snake[0] in trail:
                    # Snake runs over itself, game over
                    break

                # Increases the speed of Snake as its length increases
                timeout = 0.001 * (150 - (l / 5 + l /10) % 120)
                self.prevKey = self.key # Previous key pressed
                self.vim.session.threadsafe_call(self.update)

        self.vim.session.threadsafe_call(self.end)


    def addstr(self, lnum, cnum, string):
        line = self.buf[lnum]
        line = line[0:cnum] + string + line[cnum + len(string):]
        self.buf[lnum] = line


    def update(self):
        with self.lock:
            if self.snake[0] == self.food: # When snake eats the food
                self.food = []
                self.score += 1
                while self.food == []:
                    # Calculating next food's coordinates
                    self.food = [randint(1, 18), randint(1, 58)]
                    if self.food in self.snake: self.food = []
                self.addstr(self.food[0], self.food[1], '*')
            else:
                # [1] If it does not eat the food, length decreases
                last = self.snake.pop()
                self.addstr(last[0], last[1], ' ')
            self.addstr(self.snake[0][0], self.snake[0][1], '#')
            # Printing 'Score' and
            self.addstr(0, 2, 'Score : ' + str(self.score) + ' ')
            self.addstr(0, 27, ' SNAKE / MOVEMENTs(hjkl) EXIT(esc) PAUSE(space) ')


    def end(self):
        with self.lock:
            self.buf[:] = None
            self.buf.append("Score - " + str(self.score))
            self.buf.append("http://bitemelater.in")
            self.key_unsubscribe('k')
            self.key_unsubscribe('j')
            self.key_unsubscribe('h')
            self.key_unsubscribe('l')
            self.key_unsubscribe('<esc>')
            self.key_unsubscribe('<space>')


    def keypress(self, k):
        self.key = k


@neovim.plugin
class Snake(object):
    def __init__(self, vim):
        self.vim = vim
        self.current_game = None


    @neovim.rpc_export('keypress')
    def keypress(self, key):
        self.current_game.keypress(key)


    @neovim.command('SnakeStart', sync=True)
    def snake_start(self):
        if self.current_game:
            raise Exception('Snake already running!')
        self.current_game = Game(self.vim)
        self.current_game.start()
