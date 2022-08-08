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

## Godot nodes and scenes.

    implementation of the grid could be done with a tilemap, if its parts can be set
    or just sprites, with a sprite per tile
    sprites has the advantage that it can use tweens to move, for a better effect. though is this desired?
    also transitioning colours, animations when removed might be trickier with a tilemap

so id say creating a scene for an individual tile might be useful, with move down/left/right (tween moves), rotate (jump?), flash and remove

    area2d
        sprite
            - the colour shift of this could be changed
        animationplayer
            - normal
            - flash
        tween

for tracking the current shape, this would contain a reference to a number of sprite instances, positioning them initially and then rotating them, triggering their movement, and ultimately removing itself and triggering a line test (via an emitted signal)

    node
        tile instances

    script has
        placed
        input check for rotate, move etc
        timers for dropping and fast movement

the current shape would need a reference to the state of the board. alternatively, current shape could be subsumed into a board object? nicer if its separate i think

board scene would have the state, would initiate the current shape, track the next shape to go, do the line calculations, and emit signals about scores and next shape

main scene would have board, ui for next shape, ui for showing scores and levels etc.

## Shapes and rotations

from xelmish/samples/tetris-clone/constants.fs:

```fsharp
let shapes = [
    {   rotations = [|  [0,0; 1,0; 0,1; 1,1] |] // O
        colour = Colour.Cyan }
    {   rotations = [|  [0,0; 1,0; 2,0; 3,0]    // I
                        [2,0; 2,1; 2,2; 2,3] |]
        colour = Colour.Red }
    {   rotations = [|  [0,0; 1,0; 1,1; 2,1]    // Z
                        [2,0; 2,1; 1,1; 1,2] |] 
        colour = Colour.Green }
    {   rotations = [|  [1,0; 2,0; 1,1; 0,1]    // S
                        [1,0; 1,1; 2,1; 2,2] |] 
        colour = Colour.Blue }
    {   rotations = [|  [0,0; 1,0; 2,0; 0,1]    // L
                        [0,0; 1,0; 1,1; 1,2]
                        [0,1; 1,1; 2,1; 2,0]
                        [1,0; 1,1; 1,2; 2,2] |] 
        colour = Colour.Orange }
    {   rotations = [|  [0,0; 1,0; 2,0; 2,1]    // J
                        [1,0; 1,1; 1,2; 0,2]
                        [0,0; 0,1; 1,1; 2,1]
                        [1,0; 2,0; 1,1; 1,2] |] 
        colour = Colour.Magenta }
    {   rotations = [|  [0,0; 1,0; 2,0; 1,1]    // T
                        [1,0; 1,1; 1,2; 0,1]
                        [0,1; 1,1; 2,1; 1,0]
                        [1,0; 1,1; 1,2; 2,1] |]
        colour = Colour.Silver }
]
```