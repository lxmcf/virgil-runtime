<h1 align="center">Virgil</h1>

<p align="center">
<
    <a href="#what-is-virgil">Description</a>|
    <a href="#compiling">Compiling</a>|
    <a href="#how-to-use">Compiling</a>
>
</p>

### What is Virgil?

---

Virgil is the result of 'if it ain't broken, break it and reinvent the wheel lmao', a basic 2D game engine built using [SDL2](https://www.libsdl.org/index.php) and [Vala](https://vala.dev/) aimed at begginers to experienced developers running a Linux desktop.

### Compiling

---

Compiling will output the main runtime executable as well as the C header and Vala VAPI for game module development, you can follow the below steps on any supported platform to build Virgil:

```bash
meson build

cd build

ninja && ./virgil

```

Congratulations! you shoud now see the 'sandbox' application and are well on your way to game development!

### How to use?

---

To create a basic application that print's 'Hello World!' to the console...

```vala
// filename: Game.vala
using Virgil;

public class MyNewGame : Game {
    public override void init () {
        print ("Hello World!"\n);
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (MyNewGame);
}
```

Now you can build this using the command line as follows:

```bash
valac -o game.so --pkg gmodule-2.0 -X -fPIC -X --shared virgil.vapi Game.vala --library Game
```