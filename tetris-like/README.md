# Tetris-like

Core mechanics:

    a grid, say 10x20
    select two shapes, one to start with and one to come next
    this becomes active shape, spawning at the top of the screen, and next shape
    a timer will drop the current shape by 1 tile each tick
    when a shape can't move down, input is disabled, map is evaluated for lines, lines are removed, and the next shape tries to spawn
    if the next shape can't spawn, game over
    while a current shape is dropping, uses can execute four actions:
        they can move the shape left, or right. holding down the key scoots faster
        they can move down, which suspends the drop timer, starts a faster timer while the key is pressed
        they can rotate the shape (if the shape supports it)

    except for rotate, these actions have a press causing immediate action, followed by a delay, then if still pressed faster repetition. also when an action ends, there is a delay before the defualt timer re-enables

    when a shape can no longer move, the board is evaluated bottom to top. lines where there is a continuous row are removed and the score is incremented. tiles above a removed line are moved down. the way this can be implemented, so all continous lines are removed as once, the moves down make sense, can be tricky but not too hard.

Godot nodes and scenes.

    implementation of the grid could be done with a tilemap, if its parts can be set
    or just spritesm which a sprite per tile