<h1 align="center">Virgil</h1>
<p align="center">:construction: API is not yet final, API changes are to be expected :construction:</p>

<p align="center">
<
    <a href="#what-is-virgil">Description</a> |
    <a href="#dependencies">Dependencies</a> |
    <a href="#compiling">Compiling</a> |
    <a href="#how-to-use">Compiling</a>
>
</p>

### What is Virgil?

---

Virgil is the result of 'if it ain't broken, break it and reinvent the wheel lmao', a basic 2D game engine built using [Raylib](https://www.raylib.com/) and [Vala](https://vala.dev/) aimed at beginners to experienced developers running a Linux desktop (Windows coming soon™).

### Dependencies

---

- `raylib`

Virgil uses very minimal depencies and due to being base on Raylib; has no runtime dependencies!

To install raylib, follow the instructions [HERE](https://www.raylib.com/) then come back and continue reading on...

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

<!-- C# for nicer syntax highlighting -->
```csharp
// filename: Game.vala
using Virgil;

public class MyNewGame : Game {
    public override void start () {
        print ("Hello World!"\n);
    }
}

[ModuleInit]
public Type register_game (Module module) {
    return typeof (MyNewGame);
}
```

Now you can build this using the command line as follows:

<!-- Powershell is just for syntax highlighting -->
```powershell
valac -o game.so --pkg gmodule-2.0 -X -fPIC -X --shared virgil.vapi Game.vala --library Game
```
